-- ============================================================
-- Restaurant Management System - Database Schema
-- PostgreSQL 14+
-- ============================================================

-- Extension bach n'sta3mlou UUIDs
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- ============================================================
-- 1. RESTAURANTS (Multi-tenant root)
-- ============================================================
CREATE TABLE restaurants (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(100) NOT NULL,
    address TEXT,
    phone VARCHAR(20),
    email VARCHAR(100),
    city VARCHAR(50),
    logo_url TEXT,
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX idx_restaurants_active ON restaurants(is_active);

-- ============================================================
-- 2. USERS (Staff + clients)
-- ============================================================
CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    restaurant_id UUID REFERENCES restaurants(id) ON DELETE CASCADE,
    full_name VARCHAR(100) NOT NULL,
    phone VARCHAR(20) UNIQUE,
    email VARCHAR(100) UNIQUE,
    password_hash TEXT,
    role VARCHAR(20) NOT NULL CHECK (role IN ('admin', 'manager', 'chef', 'cashier', 'livreur', 'customer')),
    is_active BOOLEAN DEFAULT true,
    last_login TIMESTAMP,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX idx_users_restaurant ON users(restaurant_id);
CREATE INDEX idx_users_role ON users(role);
CREATE INDEX idx_users_phone ON users(phone);

-- ============================================================
-- 3. MENU ITEMS (Plats li kay-tba3ou)
-- ============================================================
CREATE TABLE menu_items (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    restaurant_id UUID REFERENCES restaurants(id) ON DELETE CASCADE,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    category VARCHAR(50), -- Tajine, Couscous, Boissons, Desserts
    price DECIMAL(8,2) NOT NULL,
    image_url TEXT,
    is_available BOOLEAN DEFAULT true,
    prep_time_minutes INT DEFAULT 15,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX idx_menu_restaurant ON menu_items(restaurant_id);
CREATE INDEX idx_menu_category ON menu_items(category);
CREATE INDEX idx_menu_available ON menu_items(is_available);

-- ============================================================
-- 4. INGREDIENTS (Sel3a kham f'makhzoun)
-- ============================================================
CREATE TABLE ingredients (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    restaurant_id UUID REFERENCES restaurants(id) ON DELETE CASCADE,
    name VARCHAR(100) NOT NULL,
    barcode VARCHAR(50), -- EAN-13 wla internal SKU
    unit VARCHAR(20) NOT NULL, -- kg, g, l, ml, unite
    current_stock DECIMAL(10,3) DEFAULT 0,
    min_stock DECIMAL(10,3) DEFAULT 0, -- Threshold dyal alerte
    avg_cost_per_unit DECIMAL(8,2), -- Prix moyen dyal achat
    supplier_name VARCHAR(100),
    supplier_phone VARCHAR(20),
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX idx_ingredients_restaurant ON ingredients(restaurant_id);
CREATE INDEX idx_ingredients_barcode ON ingredients(barcode);
CREATE INDEX idx_ingredients_low_stock ON ingredients(restaurant_id, current_stock, min_stock);

-- ============================================================
-- 5. RECIPES (Plat → Ingredients m3a quantites)
-- ============================================================
CREATE TABLE recipes (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    menu_item_id UUID REFERENCES menu_items(id) ON DELETE CASCADE,
    ingredient_id UUID REFERENCES ingredients(id) ON DELETE RESTRICT,
    quantity DECIMAL(10,3) NOT NULL, -- ch7al men ingredient f'plat wa7d
    created_at TIMESTAMP DEFAULT NOW(),
    UNIQUE(menu_item_id, ingredient_id)
);

CREATE INDEX idx_recipes_menu ON recipes(menu_item_id);
CREATE INDEX idx_recipes_ingredient ON recipes(ingredient_id);

-- ============================================================
-- 6. STOCK MOVEMENTS (Log kamla dyal 7araka)
-- ============================================================
CREATE TABLE stock_movements (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    ingredient_id UUID REFERENCES ingredients(id) ON DELETE CASCADE,
    movement_type VARCHAR(20) NOT NULL CHECK (movement_type IN ('purchase', 'sale', 'waste', 'correction', 'transfer')),
    quantity DECIMAL(10,3) NOT NULL, -- + l'dkhoul, - l'khrouj
    unit_cost DECIMAL(8,2), -- Prix dyal wa7da (ghir f'purchase)
    total_cost DECIMAL(10,2), -- quantity * unit_cost
    reason TEXT, -- "Commande #1234", "Fsed", "Inventory correction"
    order_id UUID, -- Reference l'order ila movement_type = 'sale'
    user_id UUID REFERENCES users(id), -- Chkoun dar l'harakah
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX idx_movements_ingredient ON stock_movements(ingredient_id);
CREATE INDEX idx_movements_type ON stock_movements(movement_type);
CREATE INDEX idx_movements_date ON stock_movements(created_at);
CREATE INDEX idx_movements_order ON stock_movements(order_id);

-- ============================================================
-- 7. ORDERS (Commandes)
-- ============================================================
CREATE TABLE orders (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    restaurant_id UUID REFERENCES restaurants(id) ON DELETE CASCADE,
    order_number SERIAL, -- Numero y-tzad automatiquement
    customer_id UUID REFERENCES users(id), -- NULL ila walk-in
    customer_phone VARCHAR(20),
    customer_name VARCHAR(100),
    delivery_address TEXT,
    order_type VARCHAR(20) NOT NULL CHECK (order_type IN ('dine_in', 'takeaway', 'delivery')),
    status VARCHAR(20) NOT NULL DEFAULT 'pending'
        CHECK (status IN ('pending', 'accepted', 'preparing', 'ready', 'out_for_delivery', 'delivered', 'cancelled')),
    payment_method VARCHAR(20) CHECK (payment_method IN ('cash', 'card', 'online')),
    payment_status VARCHAR(20) DEFAULT 'pending' CHECK (payment_status IN ('pending', 'paid', 'failed')),
    subtotal DECIMAL(10,2) NOT NULL,
    delivery_fee DECIMAL(6,2) DEFAULT 0,
    total DECIMAL(10,2) NOT NULL,
    notes TEXT,
    cashier_id UUID REFERENCES users(id), -- Chkoun chef/caissier qbel l'commande
    created_at TIMESTAMP DEFAULT NOW(),
    accepted_at TIMESTAMP,
    ready_at TIMESTAMP,
    delivered_at TIMESTAMP
);

CREATE INDEX idx_orders_restaurant ON orders(restaurant_id);
CREATE INDEX idx_orders_status ON orders(status);
CREATE INDEX idx_orders_date ON orders(created_at);
CREATE INDEX idx_orders_customer ON orders(customer_id);

-- ============================================================
-- 8. ORDER ITEMS (Plats f'koul commande)
-- ============================================================
CREATE TABLE order_items (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    order_id UUID REFERENCES orders(id) ON DELETE CASCADE,
    menu_item_id UUID REFERENCES menu_items(id) ON DELETE RESTRICT,
    quantity INT NOT NULL DEFAULT 1,
    unit_price DECIMAL(8,2) NOT NULL, -- Prix mnin tbe3, ma y-tghayar-ch m3a menu price
    subtotal DECIMAL(10,2) NOT NULL,
    special_notes TEXT, -- "Bla zit", "Zid salsa"
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX idx_order_items_order ON order_items(order_id);
CREATE INDEX idx_order_items_menu ON order_items(menu_item_id);

-- ============================================================
-- 9. DELIVERIES (Livraisons)
-- ============================================================
CREATE TABLE deliveries (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    order_id UUID REFERENCES orders(id) ON DELETE CASCADE UNIQUE,
    livreur_id UUID REFERENCES users(id),
    pickup_lat DECIMAL(10,7),
    pickup_lng DECIMAL(10,7),
    delivery_lat DECIMAL(10,7),
    delivery_lng DECIMAL(10,7),
    status VARCHAR(20) DEFAULT 'assigned'
        CHECK (status IN ('assigned', 'picked_up', 'en_route', 'delivered', 'failed')),
    distance_km DECIMAL(6,2),
    assigned_at TIMESTAMP DEFAULT NOW(),
    picked_up_at TIMESTAMP,
    delivered_at TIMESTAMP
);

CREATE INDEX idx_deliveries_livreur ON deliveries(livreur_id);
CREATE INDEX idx_deliveries_status ON deliveries(status);

-- ============================================================
-- TRIGGERS: Update 'updated_at' automatiquement
-- ============================================================
CREATE OR REPLACE FUNCTION update_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_restaurants_updated BEFORE UPDATE ON restaurants
    FOR EACH ROW EXECUTE FUNCTION update_updated_at();
CREATE TRIGGER trg_menu_items_updated BEFORE UPDATE ON menu_items
    FOR EACH ROW EXECUTE FUNCTION update_updated_at();
CREATE TRIGGER trg_ingredients_updated BEFORE UPDATE ON ingredients
    FOR EACH ROW EXECUTE FUNCTION update_updated_at();

-- ============================================================
-- TRIGGER MAGIQUE: Stock deduction automatic mnin kat-accept commande
-- ============================================================
CREATE OR REPLACE FUNCTION deduct_stock_on_order_accept()
RETURNS TRIGGER AS $$
DECLARE
    item RECORD;
    recipe_row RECORD;
BEGIN
    -- Ghir mnin status kay-tbedel l 'accepted'
    IF NEW.status = 'accepted' AND OLD.status = 'pending' THEN
        -- Pour koul plat f'commande
        FOR item IN SELECT * FROM order_items WHERE order_id = NEW.id LOOP
            -- Pour koul ingredient f'recipe dyal had plat
            FOR recipe_row IN
                SELECT r.ingredient_id, r.quantity * item.quantity AS total_qty
                FROM recipes r WHERE r.menu_item_id = item.menu_item_id
            LOOP
                -- Naqqes men stock
                UPDATE ingredients
                SET current_stock = current_stock - recipe_row.total_qty
                WHERE id = recipe_row.ingredient_id;

                -- Sejjel f'log
                INSERT INTO stock_movements (ingredient_id, movement_type, quantity, reason, order_id, user_id)
                VALUES (recipe_row.ingredient_id, 'sale', -recipe_row.total_qty,
                        'Commande #' || NEW.order_number, NEW.id, NEW.cashier_id);
            END LOOP;
        END LOOP;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_deduct_stock AFTER UPDATE ON orders
    FOR EACH ROW EXECUTE FUNCTION deduct_stock_on_order_accept();

-- ============================================================
-- VIEW: Low stock alerts (hiya dyal dashboard)
-- ============================================================
CREATE VIEW v_low_stock_alerts AS
SELECT
    i.id,
    i.restaurant_id,
    i.name,
    i.current_stock,
    i.min_stock,
    i.unit,
    i.supplier_name,
    i.supplier_phone,
    CASE
        WHEN i.current_stock <= (i.min_stock * 0.3) THEN 'critical'
        WHEN i.current_stock <= i.min_stock THEN 'low'
        ELSE 'ok'
    END AS alert_level
FROM ingredients i
WHERE i.current_stock <= i.min_stock;

-- ============================================================
-- VIEW: Profitability par plat (l'feature l'kbir!)
-- ============================================================
CREATE VIEW v_menu_profitability AS
SELECT
    m.id,
    m.restaurant_id,
    m.name AS plat_name,
    m.price AS selling_price,
    COALESCE(SUM(r.quantity * i.avg_cost_per_unit), 0) AS food_cost,
    m.price - COALESCE(SUM(r.quantity * i.avg_cost_per_unit), 0) AS gross_profit,
    CASE
        WHEN m.price > 0
        THEN ROUND(((m.price - COALESCE(SUM(r.quantity * i.avg_cost_per_unit), 0)) / m.price * 100)::numeric, 1)
        ELSE 0
    END AS margin_percent
FROM menu_items m
LEFT JOIN recipes r ON r.menu_item_id = m.id
LEFT JOIN ingredients i ON i.id = r.ingredient_id
GROUP BY m.id, m.restaurant_id, m.name, m.price;

-- ============================================================
-- SAMPLE DATA (bach t-commenci tjarreb)
-- ============================================================
INSERT INTO restaurants (id, name, city, phone) VALUES
    ('11111111-1111-1111-1111-111111111111', 'Al Baraka', 'Agadir', '0528123456');

INSERT INTO ingredients (restaurant_id, name, unit, current_stock, min_stock, avg_cost_per_unit) VALUES
    ('11111111-1111-1111-1111-111111111111', 'Djaj', 'kg', 2.4, 10, 35),
    ('11111111-1111-1111-1111-111111111111', 'Bslla', 'kg', 6.5, 10, 8),
    ('11111111-1111-1111-1111-111111111111', 'Matisha', 'kg', 1.8, 8, 12),
    ('11111111-1111-1111-1111-111111111111', 'Zit d''olive', 'l', 4.2, 5, 80);

INSERT INTO menu_items (restaurant_id, name, category, price) VALUES
    ('11111111-1111-1111-1111-111111111111', 'Tajine Djaj', 'Tajines', 65),
    ('11111111-1111-1111-1111-111111111111', 'Couscous Kheddra', 'Couscous', 55),
    ('11111111-1111-1111-1111-111111111111', 'Pastilla', 'Specialites', 80);
