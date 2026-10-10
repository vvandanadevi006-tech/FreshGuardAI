-- FreshGuard AI Deterministic Demo Seed Data
-- Safe to re-run

-- 1. STORES
INSERT INTO public.stores (id, code, name, location, max_capacity_units, operational_cost_per_day)
VALUES 
    ('11111111-1111-1111-1111-111111111111', 'STORE-METRO-01', 'FreshGuard Metro Downtown', '100 Main St, Central Metro', 4000, 320.00),
    ('22222222-2222-2222-2222-222222222222', 'STORE-WEST-02', 'FreshGuard Westside Suburban', '450 West Ave, Oakridge', 6500, 280.00),
    ('33333333-3333-3333-3333-333333333333', 'STORE-EAST-03', 'FreshGuard Eastside Express', '12 Harbor Blvd, East Bay', 2000, 190.00)
ON CONFLICT (code) DO UPDATE SET 
    name = EXCLUDED.name,
    location = EXCLUDED.location;

-- 2. PRODUCTS
INSERT INTO public.products (id, sku, name, category, unit_price, unit_cost, shelf_life_days, storage_type, max_discount_pct)
VALUES
    ('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'SKU-MILK-ORG', 'Organic Whole Milk 1 Gallon', 'Dairy', 4.80, 2.80, 7, 'chilled', 50.00),
    ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 'SKU-AVOCADO-4P', 'Ripe Hass Avocados 4-Pack', 'Produce', 5.20, 2.60, 5, 'ambient', 40.00),
    ('cccccccc-cccc-cccc-cccc-cccccccccccc', 'SKU-SALMON-500', 'Wild Caught Salmon Fillet 500g', 'Seafood', 14.50, 8.50, 3, 'chilled', 45.00),
    ('dddddddd-dddd-dddd-dddd-dddddddddddd', 'SKU-SOURDOUGH-ART', 'Organic Artisan Sourdough', 'Bakery', 6.00, 2.20, 4, 'ambient', 50.00),
    ('eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee', 'SKU-STRAWBERRY-1LB', 'Fresh Strawberries 1lb', 'Produce', 4.50, 2.10, 4, 'chilled', 40.00)
ON CONFLICT (sku) DO UPDATE SET 
    name = EXCLUDED.name,
    unit_price = EXCLUDED.unit_price,
    unit_cost = EXCLUDED.unit_cost;

-- 3. INVENTORY BATCHES (Key scenario: The 90-Minute Rescue)
-- Store-Metro Milk batch B-MLK-90M has 85 units expiring in 1.5 days! Normal sales = 14 units/day => 64 units exposed to waste!
INSERT INTO public.inventory_batches (id, batch_code, store_id, product_id, initial_quantity, current_quantity, received_date, expiry_date, status)
VALUES
    ('b1111111-1111-1111-1111-111111111111', 'B-MLK-90M-01', '11111111-1111-1111-1111-111111111111', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 100, 85, CURRENT_DATE - INTERVAL '5 days', CURRENT_DATE + INTERVAL '2 days', 'active'),
    ('b2222222-2222-2222-2222-222222222222', 'B-SALMON-CRIT-02', '11111111-1111-1111-1111-111111111111', 'cccccccc-cccc-cccc-cccc-cccccccccccc', 30, 24, CURRENT_DATE - INTERVAL '2 days', CURRENT_DATE + INTERVAL '1 day', 'active'),
    ('b3333333-3333-3333-3333-333333333333', 'B-AVO-MID-03', '11111111-1111-1111-1111-111111111111', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 50, 38, CURRENT_DATE - INTERVAL '2 days', CURRENT_DATE + INTERVAL '3 days', 'active'),
    ('b4444444-4444-4444-4444-444444444444', 'B-BREAD-FRESH-04', '11111111-1111-1111-1111-111111111111', 'dddddddd-dddd-dddd-dddd-dddddddddddd', 40, 18, CURRENT_DATE - INTERVAL '1 day', CURRENT_DATE + INTERVAL '3 days', 'active'),
    ('b5555555-5555-5555-5555-555555555555', 'B-BERRY-WARN-05', '11111111-1111-1111-1111-111111111111', 'eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee', 60, 42, CURRENT_DATE - INTERVAL '2 days', CURRENT_DATE + INTERVAL '2 days', 'active'),
    -- Store Westside Batches (Healthy inventory with high dairy demand)
    ('b6666666-6666-6666-6666-666666666666', 'B-MLK-WEST-01', '22222222-2222-2222-2222-222222222222', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 120, 15, CURRENT_DATE - INTERVAL '1 day', CURRENT_DATE + INTERVAL '6 days', 'active'),
    ('b7777777-7777-7777-7777-777777777777', 'B-SALMON-WEST-02', '22222222-2222-2222-2222-222222222222', 'cccccccc-cccc-cccc-cccc-cccccccccccc', 25, 20, CURRENT_DATE - INTERVAL '1 day', CURRENT_DATE + INTERVAL '2 days', 'active')
ON CONFLICT (store_id, product_id, batch_code) DO UPDATE SET 
    current_quantity = EXCLUDED.current_quantity,
    expiry_date = EXCLUDED.expiry_date;

-- 4. SALES HISTORY (Last 14 days sample sales)
INSERT INTO public.sales_history (store_id, product_id, sale_date, quantity_sold, promotion_active, weather_condition)
SELECT 
    '11111111-1111-1111-1111-111111111111',
    'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa',
    CURRENT_DATE - (d || ' days')::INTERVAL,
    14 + (d % 3),
    false,
    'clear'
FROM generate_series(1, 14) as d;

-- Westside milk demand is higher (avg 32/day)
INSERT INTO public.sales_history (store_id, product_id, sale_date, quantity_sold, promotion_active, weather_condition)
SELECT 
    '22222222-2222-2222-2222-222222222222',
    'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa',
    CURRENT_DATE - (d || ' days')::INTERVAL,
    30 + (d % 6),
    false,
    'clear'
FROM generate_series(1, 14) as d;

-- Salmon downtown sales (avg 6/day)
INSERT INTO public.sales_history (store_id, product_id, sale_date, quantity_sold, promotion_active, weather_condition)
SELECT 
    '11111111-1111-1111-1111-111111111111',
    'cccccccc-cccc-cccc-cccc-cccccccccccc',
    CURRENT_DATE - (d || ' days')::INTERVAL,
    6 + (d % 2),
    false,
    'clear'
FROM generate_series(1, 14) as d;

-- Demo audit record
INSERT INTO public.audit_logs (event_type, user_role, store_id, details)
VALUES (
    'SYSTEM_INITIALIZED',
    'admin',
    '11111111-1111-1111-1111-111111111111',
    '{"message": "Deterministic demo environment initialized with 90-Minute Rescue scenario"}'::jsonb
);
