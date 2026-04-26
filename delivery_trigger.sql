-- ============================================================
-- AUTO-CREATE DELIVERY RECORD
-- Mnin kat-dkhol commande livraison, kay-tsawb row f'deliveries
-- ============================================================

CREATE OR REPLACE FUNCTION auto_create_delivery()
RETURNS TRIGGER AS $$
BEGIN
    -- Ghir ila howa livraison ou status kay-tbeddel l 'ready'
    IF NEW.order_type = 'delivery' AND NEW.status = 'ready' AND OLD.status != 'ready' THEN
        -- Check ila déjà kayna row f'deliveries
        IF NOT EXISTS (SELECT 1 FROM deliveries WHERE order_id = NEW.id) THEN
            INSERT INTO deliveries (order_id, status)
            VALUES (NEW.id, 'assigned');
        END IF;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_auto_delivery ON orders;
CREATE TRIGGER trg_auto_delivery AFTER UPDATE ON orders
    FOR EACH ROW EXECUTE FUNCTION auto_create_delivery();

-- ============================================================
-- VIEW: Deliveries pending (l'livreurs)
-- ============================================================
CREATE OR REPLACE VIEW v_pending_deliveries AS
SELECT 
    d.id AS delivery_id,
    d.status AS delivery_status,
    d.livreur_id,
    d.assigned_at,
    d.picked_up_at,
    o.id AS order_id,
    o.order_number,
    o.total,
    o.customer_name,
    o.customer_phone,
    o.delivery_address,
    o.notes,
    o.created_at AS order_created_at,
    o.ready_at
FROM deliveries d
JOIN orders o ON o.id = d.order_id
WHERE d.status IN ('assigned', 'picked_up', 'en_route')
ORDER BY o.ready_at ASC;
