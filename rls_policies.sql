-- ============================================================
-- ROW LEVEL SECURITY (RLS) POLICIES
-- Must run ba3d ma t-crée tables + run sample data
-- ============================================================

-- Enable RLS 3la kol tables mouhimin
ALTER TABLE restaurants ENABLE ROW LEVEL SECURITY;
ALTER TABLE users ENABLE ROW LEVEL SECURITY;
ALTER TABLE menu_items ENABLE ROW LEVEL SECURITY;
ALTER TABLE ingredients ENABLE ROW LEVEL SECURITY;
ALTER TABLE recipes ENABLE ROW LEVEL SECURITY;
ALTER TABLE stock_movements ENABLE ROW LEVEL SECURITY;
ALTER TABLE orders ENABLE ROW LEVEL SECURITY;
ALTER TABLE order_items ENABLE ROW LEVEL SECURITY;
ALTER TABLE deliveries ENABLE ROW LEVEL SECURITY;
ALTER TABLE modifier_groups ENABLE ROW LEVEL SECURITY;
ALTER TABLE modifiers ENABLE ROW LEVEL SECURITY;
ALTER TABLE order_item_modifiers ENABLE ROW LEVEL SECURITY;

-- ============================================================
-- HELPER FUNCTION: Khdem restaurant_id dyal user current
-- ============================================================
CREATE OR REPLACE FUNCTION auth.user_restaurant_id()
RETURNS UUID AS $$
  SELECT restaurant_id FROM users WHERE id = auth.uid()
$$ LANGUAGE sql SECURITY DEFINER STABLE;

-- ============================================================
-- HELPER: Khdem role dyal user current
-- ============================================================
CREATE OR REPLACE FUNCTION auth.user_role()
RETURNS VARCHAR AS $$
  SELECT role FROM users WHERE id = auth.uid()
$$ LANGUAGE sql SECURITY DEFINER STABLE;

-- ============================================================
-- POLICIES: MENU_ITEMS
-- ============================================================
-- Users kay-chofo menu dyal restaurant dyalhom ghir
CREATE POLICY "Users see own restaurant menu"
ON menu_items FOR SELECT
USING (restaurant_id = auth.user_restaurant_id());

-- Ghir admin/manager kay-qder y-baddel menu
CREATE POLICY "Admin/Manager manage menu"
ON menu_items FOR ALL
USING (
    restaurant_id = auth.user_restaurant_id()
    AND auth.user_role() IN ('admin', 'manager')
);

-- ============================================================
-- POLICIES: INGREDIENTS (Stock)
-- ============================================================
CREATE POLICY "Users see own restaurant ingredients"
ON ingredients FOR SELECT
USING (restaurant_id = auth.user_restaurant_id());

CREATE POLICY "Admin/Manager/Chef manage ingredients"
ON ingredients FOR ALL
USING (
    restaurant_id = auth.user_restaurant_id()
    AND auth.user_role() IN ('admin', 'manager', 'chef')
);

-- ============================================================
-- POLICIES: ORDERS
-- ============================================================
-- Staff kay-chouf orders dyal restaurant dyalhom
CREATE POLICY "Staff see own restaurant orders"
ON orders FOR SELECT
USING (
    restaurant_id = auth.user_restaurant_id()
    AND auth.user_role() IN ('admin', 'manager', 'chef', 'cashier')
);

-- Livreur kay-chouf ghir orders li assigned lih
CREATE POLICY "Livreur sees assigned orders"
ON orders FOR SELECT
USING (
    auth.user_role() = 'livreur'
    AND id IN (SELECT order_id FROM deliveries WHERE livreur_id = auth.uid())
);

-- Customer kay-chouf orders dyalo ghir
CREATE POLICY "Customer sees own orders"
ON orders FOR SELECT
USING (customer_id = auth.uid());

-- Cashier kay-qder y-crée orders
CREATE POLICY "Cashier creates orders"
ON orders FOR INSERT
WITH CHECK (
    restaurant_id = auth.user_restaurant_id()
    AND auth.user_role() IN ('cashier', 'manager', 'admin')
);

-- Status updates
CREATE POLICY "Staff update order status"
ON orders FOR UPDATE
USING (
    restaurant_id = auth.user_restaurant_id()
    AND auth.user_role() IN ('admin', 'manager', 'chef', 'cashier')
);

-- ============================================================
-- POLICIES: ORDER_ITEMS
-- ============================================================
CREATE POLICY "View order items"
ON order_items FOR SELECT
USING (
    order_id IN (SELECT id FROM orders) -- kay-7awla RLS dyal orders
);

CREATE POLICY "Cashier manages order items"
ON order_items FOR ALL
USING (
    auth.user_role() IN ('cashier', 'manager', 'admin')
);

-- ============================================================
-- POLICIES: DELIVERIES
-- ============================================================
CREATE POLICY "Livreur sees own deliveries"
ON deliveries FOR SELECT
USING (
    livreur_id = auth.uid()
    OR auth.user_role() IN ('admin', 'manager')
);

CREATE POLICY "Livreur updates own delivery status"
ON deliveries FOR UPDATE
USING (livreur_id = auth.uid());

-- ============================================================
-- POLICIES: USERS
-- ============================================================
-- Users kay-chofo rashom
CREATE POLICY "Users see own profile"
ON users FOR SELECT
USING (id = auth.uid() OR auth.user_role() IN ('admin', 'manager'));

-- ============================================================
-- POLICIES: PUBLIC READ (Menu kay-ban l'site client)
-- ============================================================
-- Tabdél: l' site client khassou y-chouf menu bla login
CREATE POLICY "Public can view available menu"
ON menu_items FOR SELECT
USING (is_available = true);

CREATE POLICY "Public can view modifiers"
ON modifiers FOR SELECT
USING (is_available = true);

CREATE POLICY "Public can view modifier groups"
ON modifier_groups FOR SELECT
USING (true);
