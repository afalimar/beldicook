-- ============================================================
-- MODIFIERS EXTENSION
-- Zid had tables l'schema principal dyalek
-- ============================================================

-- 10. MODIFIER GROUPS (Cuisson, Na7(h)i, Zid supplément)
CREATE TABLE modifier_groups (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    menu_item_id UUID REFERENCES menu_items(id) ON DELETE CASCADE,
    name VARCHAR(50) NOT NULL,
    selection_type VARCHAR(20) NOT NULL CHECK (selection_type IN ('single', 'multiple')),
    is_required BOOLEAN DEFAULT false,
    min_selections INT DEFAULT 0,
    max_selections INT,
    display_order INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX idx_mod_groups_menu ON modifier_groups(menu_item_id);

-- 11. MODIFIERS (Chorba, Bla matisha, Double djaj...)
CREATE TABLE modifiers (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    modifier_group_id UUID REFERENCES modifier_groups(id) ON DELETE CASCADE,
    name VARCHAR(80) NOT NULL,
    price_delta DECIMAL(6,2) DEFAULT 0,
    action_type VARCHAR(20) DEFAULT 'add' CHECK (action_type IN ('add', 'remove', 'choice')),
    affects_ingredient_id UUID REFERENCES ingredients(id) ON DELETE SET NULL,
    quantity_delta DECIMAL(10,3),
    is_available BOOLEAN DEFAULT true,
    display_order INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX idx_modifiers_group ON modifiers(modifier_group_id);

-- 12. ORDER ITEM MODIFIERS (Chkoun khtar ach f'order)
CREATE TABLE order_item_modifiers (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    order_item_id UUID REFERENCES order_items(id) ON DELETE CASCADE,
    modifier_id UUID REFERENCES modifiers(id) ON DELETE RESTRICT,
    price_delta DECIMAL(6,2) NOT NULL,
    snapshot_name VARCHAR(80) NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX idx_oim_order_item ON order_item_modifiers(order_item_id);

-- ============================================================
-- Sample data - Modifiers l'Tajine Djaj
-- ============================================================

WITH tajine AS (
    SELECT id FROM menu_items WHERE name = 'Tajine Djaj' LIMIT 1
),
djaj AS (SELECT id FROM ingredients WHERE name = 'Djaj' LIMIT 1),
matisha AS (SELECT id FROM ingredients WHERE name = 'Matisha' LIMIT 1)

INSERT INTO modifier_groups (menu_item_id, name, selection_type, is_required, min_selections, max_selections, display_order)
SELECT id, 'Cuisson', 'single', true, 1, 1, 1 FROM tajine
UNION ALL
SELECT id, 'Na7(h)i ingredient', 'multiple', false, 0, 3, 2 FROM tajine
UNION ALL
SELECT id, 'Zid supplement', 'multiple', false, 0, 5, 3 FROM tajine;

-- ============================================================
-- VIEW: Full menu m3a modifiers (useful l'caisse)
-- ============================================================
CREATE VIEW v_menu_with_modifiers AS
SELECT
    m.id AS menu_item_id,
    m.name AS plat_name,
    m.price,
    m.category,
    json_agg(
        json_build_object(
            'group_id', mg.id,
            'group_name', mg.name,
            'type', mg.selection_type,
            'required', mg.is_required,
            'modifiers', (
                SELECT json_agg(json_build_object(
                    'id', mo.id,
                    'name', mo.name,
                    'price_delta', mo.price_delta,
                    'available', mo.is_available
                ))
                FROM modifiers mo
                WHERE mo.modifier_group_id = mg.id
            )
        ) ORDER BY mg.display_order
    ) FILTER (WHERE mg.id IS NOT NULL) AS modifier_groups
FROM menu_items m
LEFT JOIN modifier_groups mg ON mg.menu_item_id = m.id
WHERE m.is_available = true
GROUP BY m.id, m.name, m.price, m.category;
