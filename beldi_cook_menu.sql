-- ============================================================
-- BELDI COOK - Real Menu Import
-- Restaurant: Beldi Cook (Moroccan Taste)
-- Location: Agadir
-- Experience: 10 years
-- ============================================================
-- Had file kay-import menu real dyalek (~75 plats)
-- 
-- ⚠️ INSTRUCTIONS:
-- 1. Run had file F'Supabase SQL Editor
-- 2. Khass restaurant_schema.sql ykoun déjà run
-- 3. Ila baghi t-bdel data sample qadima, run had file
--    kay-7id sample data ou kay-zid menu real
-- ============================================================

-- ============================================================
-- 1. UPDATE RESTAURANT INFO
-- ============================================================
UPDATE restaurants 
SET 
    name = 'Beldi Cook',
    city = 'Agadir',
    phone = '0528123456',
    email = 'afalimar@gmail.com'
WHERE id = '11111111-1111-1111-1111-111111111111';

-- Ila restaurant ma kayn-ch, t-crée-h
INSERT INTO restaurants (id, name, city, phone, email)
SELECT '11111111-1111-1111-1111-111111111111', 'Beldi Cook', 'Agadir', '0528123456', 'afalimar@gmail.com'
WHERE NOT EXISTS (SELECT 1 FROM restaurants WHERE id = '11111111-1111-1111-1111-111111111111');

-- ============================================================
-- 2. CLEAN OLD SAMPLE DATA
-- ============================================================
-- 7id menu items qadiim (sample)
DELETE FROM menu_items WHERE restaurant_id = '11111111-1111-1111-1111-111111111111';

-- 7id ingredients qadiim (sample)
DELETE FROM ingredients WHERE restaurant_id = '11111111-1111-1111-1111-111111111111';

-- ============================================================
-- 3. INGREDIENTS DYAL BELDI COOK
-- ============================================================
INSERT INTO ingredients (restaurant_id, name, unit, current_stock, min_stock, avg_cost_per_unit) VALUES
    -- Lhoum
    ('11111111-1111-1111-1111-111111111111', 'Djaj (poulet)', 'kg', 20, 10, 35),
    ('11111111-1111-1111-1111-111111111111', 'L7am b9ri (viande)', 'kg', 15, 8, 110),
    ('11111111-1111-1111-1111-111111111111', 'Dinde fumée', 'kg', 5, 3, 80),
    ('11111111-1111-1111-1111-111111111111', 'Khliaa', 'kg', 3, 2, 120),
    ('11111111-1111-1111-1111-111111111111', 'Sardine', 'kg', 8, 5, 25),
    ('11111111-1111-1111-1111-111111111111', 'L7out (poisson)', 'kg', 10, 5, 60),
    ('11111111-1111-1111-1111-111111111111', 'Crevette', 'kg', 3, 2, 150),
    ('11111111-1111-1111-1111-111111111111', 'Thon', 'kg', 2, 1, 80),
    -- Khoder
    ('11111111-1111-1111-1111-111111111111', 'Matisha (tomate)', 'kg', 25, 10, 12),
    ('11111111-1111-1111-1111-111111111111', 'Bslla (oignon)', 'kg', 30, 15, 8),
    ('11111111-1111-1111-1111-111111111111', 'Khzzou (carottes)', 'kg', 15, 8, 10),
    ('11111111-1111-1111-1111-111111111111', 'Btata (pomme de terre)', 'kg', 30, 15, 7),
    ('11111111-1111-1111-1111-111111111111', 'Khyar (concombre)', 'kg', 8, 4, 12),
    ('11111111-1111-1111-1111-111111111111', 'Ainab (haricot blanc)', 'kg', 5, 3, 18),
    ('11111111-1111-1111-1111-111111111111', 'L3ades (lentilles)', 'kg', 6, 3, 16),
    ('11111111-1111-1111-1111-111111111111', 'Loubia khder (haricot vert)', 'kg', 4, 2, 14),
    ('11111111-1111-1111-1111-111111111111', 'Barba (betterave)', 'kg', 4, 2, 8),
    ('11111111-1111-1111-1111-111111111111', 'Felfla (poivron)', 'kg', 6, 3, 15),
    ('11111111-1111-1111-1111-111111111111', 'Avocat', 'kg', 3, 2, 35),
    ('11111111-1111-1111-1111-111111111111', 'Ms3di (epinards)', 'kg', 4, 2, 12),
    -- Lasasiyat
    ('11111111-1111-1111-1111-111111111111', 'Zit zitoun', 'l', 10, 5, 80),
    ('11111111-1111-1111-1111-111111111111', 'Zit l3am (huile)', 'l', 15, 8, 25),
    ('11111111-1111-1111-1111-111111111111', 'Zitoun (olives)', 'kg', 8, 4, 30),
    ('11111111-1111-1111-1111-111111111111', 'Smen', 'kg', 2, 1, 90),
    ('11111111-1111-1111-1111-111111111111', 'Mlh', 'kg', 5, 2, 5),
    -- Hbob
    ('11111111-1111-1111-1111-111111111111', 'Smid couscous', 'kg', 25, 10, 15),
    ('11111111-1111-1111-1111-111111111111', 'Belboula', 'kg', 10, 5, 18),
    ('11111111-1111-1111-1111-111111111111', 'Farina', 'kg', 30, 15, 6),
    ('11111111-1111-1111-1111-111111111111', 'Smida', 'kg', 15, 8, 8),
    -- Beid + Hlib
    ('11111111-1111-1111-1111-111111111111', 'Beid (oeufs)', 'unite', 200, 100, 1.5),
    ('11111111-1111-1111-1111-111111111111', 'Jben', 'kg', 5, 3, 60),
    ('11111111-1111-1111-1111-111111111111', 'Fromage Kiri', 'kg', 3, 2, 80),
    ('11111111-1111-1111-1111-111111111111', 'Fromage rouge', 'kg', 2, 1, 90),
    ('11111111-1111-1111-1111-111111111111', 'Fromage La Vache Qui Rit', 'kg', 2, 1, 75),
    ('11111111-1111-1111-1111-111111111111', 'Lben', 'l', 8, 4, 8),
    -- Specials
    ('11111111-1111-1111-1111-111111111111', 'Tmer (dattes)', 'kg', 5, 2, 60),
    ('11111111-1111-1111-1111-111111111111', '3sel (miel)', 'kg', 3, 1, 120),
    ('11111111-1111-1111-1111-111111111111', 'Amlou', 'kg', 2, 1, 100),
    ('11111111-1111-1111-1111-111111111111', 'Brqouq (pruneaux)', 'kg', 3, 2, 50),
    ('11111111-1111-1111-1111-111111111111', 'Chebakia', 'kg', 2, 1, 80),
    -- Fawakah
    ('11111111-1111-1111-1111-111111111111', 'Limoun (orange)', 'kg', 15, 8, 8),
    ('11111111-1111-1111-1111-111111111111', 'Banane', 'kg', 8, 4, 12),
    ('11111111-1111-1111-1111-111111111111', 'Tffah (pomme)', 'kg', 10, 5, 15),
    ('11111111-1111-1111-1111-111111111111', 'Fraise', 'kg', 4, 2, 35),
    ('11111111-1111-1111-1111-111111111111', 'Ananas', 'kg', 3, 2, 30),
    ('11111111-1111-1111-1111-111111111111', 'Mangue', 'kg', 3, 2, 40),
    ('11111111-1111-1111-1111-111111111111', 'Kiwi', 'kg', 2, 1, 35),
    ('11111111-1111-1111-1111-111111111111', 'Framboise', 'kg', 2, 1, 80);

-- ============================================================
-- 4. MENU ITEMS - PETIT DÉJEUNER (FLOUR)
-- ============================================================
INSERT INTO menu_items (restaurant_id, name, description, category, price, is_available, prep_time_minutes) VALUES
    ('11111111-1111-1111-1111-111111111111', 'Khfif Drif', 'Hssoua Belboula avec dattes + Batboute (Miel + Fromage) ou (Omelette + fromage kiri) + Boisson chaude au choix', 'Petit Déjeuner', 20, true, 10),
    ('11111111-1111-1111-1111-111111111111', 'Marrakchi', 'Hssoua Belboula avec dattes + Jus dorange + Boisson chaude + Mqila a la tomate avec 2 oeufs + Batboute + Huile dolive + Olives', 'Petit Déjeuner', 30, true, 15),
    ('11111111-1111-1111-1111-111111111111', 'Soussi', 'Hssoua Belboula + Jus dorange + Boisson chaude + Batboute + (Miel + Jben + Amlou + huile dolive + olives)', 'Petit Déjeuner', 33, true, 15),
    ('11111111-1111-1111-1111-111111111111', 'El Fassi', 'Hssoua Belboula + Jus dorange + Boisson chaude + Mqila de Khliaa avec 2 oeufs + Huile dolive + Olives + Batboute', 'Petit Déjeuner', 35, true, 15),
    ('11111111-1111-1111-1111-111111111111', 'Chamaly', 'Hssoua Belboula + Jus dorange + Boisson chaude + Assiette: oeuf au plat + dinde fumée + Jben + Fromage kiri + huile dolive + Olives + Batboute', 'Petit Déjeuner', 37, true, 15),
    ('11111111-1111-1111-1111-111111111111', 'Beldi Cook (Petit Déj)', 'Hssoua Belboula + Jus dorange + Boisson chaude + Harcha + Mssemen + Baghrir + batboute + maloui + Miel + Jben + Amlou + Huile dolive + Fromage kiri + Oeuf Omelette', 'Petit Déjeuner', 43, true, 20);

-- ============================================================
-- 5. MENU ITEMS - PETIT DÉJEUNER À COMPOSER
-- ============================================================
INSERT INTO menu_items (restaurant_id, name, description, category, price, is_available, prep_time_minutes) VALUES
    ('11111111-1111-1111-1111-111111111111', 'Harira Marocain (chebakia, dattes, oeuf dur)', 'Soupe traditionnelle marocaine complète', 'À Composer', 15, true, 5),
    ('11111111-1111-1111-1111-111111111111', 'Hssoua Belboula avec dattes', 'Soupe à base dorge', 'À Composer', 8, true, 5),
    ('11111111-1111-1111-1111-111111111111', 'Harira Marocain', 'Soupe marocaine simple', 'À Composer', 10, true, 5),
    ('11111111-1111-1111-1111-111111111111', 'Maloui (madhoun + 3dhs)', 'Crêpe feuilletée marocaine', 'À Composer', 4, true, 3),
    ('11111111-1111-1111-1111-111111111111', 'Mssemen (madhoun + 3dhs)', 'Crêpe traditionnelle', 'À Composer', 4, true, 3),
    ('11111111-1111-1111-1111-111111111111', 'Baghrir (madhoun + 3dhs)', 'Crêpe à mille trous', 'À Composer', 3, true, 3),
    ('11111111-1111-1111-1111-111111111111', 'Harcha (madhoun + 3dhs)', 'Galette de semoule', 'À Composer', 4, true, 3),
    ('11111111-1111-1111-1111-111111111111', 'Batbout (madhoun + 3dhs)', 'Petit pain marocain', 'À Composer', 3, true, 3),
    ('11111111-1111-1111-1111-111111111111', 'Amlou', 'Pâte amandes/argan/miel', 'À Composer', 9, true, 1),
    ('11111111-1111-1111-1111-111111111111', 'Huile dolive', 'Huile dolive du terroir', 'À Composer', 5, true, 1),
    ('11111111-1111-1111-1111-111111111111', 'Olives (verte ou noire)', 'Olives marinées maison', 'À Composer', 5, true, 1),
    ('11111111-1111-1111-1111-111111111111', 'Jben', 'Fromage frais traditionnel', 'À Composer', 5, true, 1),
    ('11111111-1111-1111-1111-111111111111', 'Dinde Fumée (50g)', 'Dinde fumée tranchée', 'À Composer', 8, true, 1),
    ('11111111-1111-1111-1111-111111111111', 'Oeuf dur', 'Oeuf dur', 'À Composer', 3, true, 5),
    ('11111111-1111-1111-1111-111111111111', 'Fromage Rouge (50g)', 'Fromage rouge', 'À Composer', 8, true, 1),
    ('11111111-1111-1111-1111-111111111111', 'Fromage Kiri', 'Portion fromage Kiri', 'À Composer', 3, true, 1),
    ('11111111-1111-1111-1111-111111111111', 'Fromage La Vache Qui Rit', 'Portion fromage', 'À Composer', 2, true, 1),
    ('11111111-1111-1111-1111-111111111111', 'Miel pur', 'Miel pur du terroir', 'À Composer', 7, true, 1);

-- ============================================================
-- 6. MENU ITEMS - MQILAT
-- ============================================================
INSERT INTO menu_items (restaurant_id, name, description, category, price, is_available, prep_time_minutes) VALUES
    ('11111111-1111-1111-1111-111111111111', 'Mqila Nature 2 oeufs', 'Mqila nature avec 2 oeufs', 'Mqilat', 8, true, 10),
    ('11111111-1111-1111-1111-111111111111', 'Mqila Nature 3 oeufs', 'Mqila nature avec 3 oeufs', 'Mqilat', 12, true, 10),
    ('11111111-1111-1111-1111-111111111111', 'Mqila Epinards 2 oeufs', 'Mqila aux epinards avec 2 oeufs', 'Mqilat', 10, true, 12),
    ('11111111-1111-1111-1111-111111111111', 'Mqila Epinards 3 oeufs', 'Mqila aux epinards avec 3 oeufs', 'Mqilat', 15, true, 12),
    ('11111111-1111-1111-1111-111111111111', 'Mqila Tomate 2 oeufs', 'Mqila à la tomate avec 2 oeufs', 'Mqilat', 12, true, 12),
    ('11111111-1111-1111-1111-111111111111', 'Mqila Tomate 3 oeufs', 'Mqila à la tomate avec 3 oeufs', 'Mqilat', 17, true, 12),
    ('11111111-1111-1111-1111-111111111111', 'Mqila Kefta 2 oeufs', 'Mqila à la kefta avec 2 oeufs', 'Mqilat', 18, true, 15),
    ('11111111-1111-1111-1111-111111111111', 'Mqila Kefta 3 oeufs', 'Mqila à la kefta avec 3 oeufs', 'Mqilat', 23, true, 15),
    ('11111111-1111-1111-1111-111111111111', 'Mqila Khliaa 2 oeufs', 'Mqila au khliaa avec 2 oeufs', 'Mqilat', 18, true, 15),
    ('11111111-1111-1111-1111-111111111111', 'Mqila Khliaa 3 oeufs', 'Mqila au khliaa avec 3 oeufs', 'Mqilat', 23, true, 15),
    ('11111111-1111-1111-1111-111111111111', 'Mqila Crevette 2 oeufs', 'Mqila aux crevettes avec 2 oeufs', 'Mqilat', 28, true, 15),
    ('11111111-1111-1111-1111-111111111111', 'Mqila Crevette 3 oeufs', 'Mqila aux crevettes avec 3 oeufs', 'Mqilat', 32, true, 15);

-- ============================================================
-- 7. MENU ITEMS - SUR COMMANDE
-- ============================================================
INSERT INTO menu_items (restaurant_id, name, description, category, price, is_available, prep_time_minutes) VALUES
    ('11111111-1111-1111-1111-111111111111', 'Sefa Prestige (10 pers)', 'Sefa prestige pour 10 personnes', 'Sur Commande', 170, true, 60),
    ('11111111-1111-1111-1111-111111111111', 'Pastila Poulet (5 pers)', 'Pastilla au poulet pour 5 personnes', 'Sur Commande', 300, true, 90),
    ('11111111-1111-1111-1111-111111111111', 'Pastila Poulet (6-8 pers)', 'Pastilla au poulet pour 6 à 8 personnes', 'Sur Commande', 550, true, 90),
    ('11111111-1111-1111-1111-111111111111', 'Pastila Poulet (10-12 pers)', 'Pastilla au poulet pour 10 à 12 personnes', 'Sur Commande', 650, true, 120),
    ('11111111-1111-1111-1111-111111111111', 'Pastila Poisson (5 pers)', 'Pastilla au poisson pour 5 personnes', 'Sur Commande', 400, true, 90),
    ('11111111-1111-1111-1111-111111111111', 'Pastila Poisson (8 pers)', 'Pastilla au poisson pour 8 personnes', 'Sur Commande', 650, true, 90),
    ('11111111-1111-1111-1111-111111111111', 'Pastila Poisson (12 pers)', 'Pastilla au poisson pour 12 personnes', 'Sur Commande', 800, true, 120),
    ('11111111-1111-1111-1111-111111111111', 'Poulet Daghmira 3 poulets', 'Poulet à la daghmira (3 poulets)', 'Sur Commande', 390, true, 75),
    ('11111111-1111-1111-1111-111111111111', 'Poulet Daghmira 4 poulets', 'Poulet à la daghmira (4 poulets)', 'Sur Commande', 520, true, 75),
    ('11111111-1111-1111-1111-111111111111', 'Poulet Rôti aux Légumes 3 poulets', 'Poulet rôti aux légumes (3 poulets)', 'Sur Commande', 650, true, 90),
    ('11111111-1111-1111-1111-111111111111', 'Poulet Rôti aux Légumes 4 poulets', 'Poulet rôti aux légumes (4 poulets)', 'Sur Commande', 750, true, 90),
    ('11111111-1111-1111-1111-111111111111', 'Refissa Marocaine 3 poulets', 'Refissa traditionnelle (3 poulets, 2kg trid)', 'Sur Commande', 700, true, 90),
    ('11111111-1111-1111-1111-111111111111', 'Viande aux Pruneaux 3kg', 'Viande aux pruneaux 3kg', 'Sur Commande', 650, true, 120),
    ('11111111-1111-1111-1111-111111111111', 'Viande aux Pruneaux 4kg', 'Viande aux pruneaux 4kg', 'Sur Commande', 750, true, 120);

-- ============================================================
-- 8. MENU ITEMS - ENTRÉES
-- ============================================================
INSERT INTO menu_items (restaurant_id, name, description, category, price, is_available, prep_time_minutes) VALUES
    ('11111111-1111-1111-1111-111111111111', 'Salade Marocaine (entrée)', 'Salade marocaine traditionnelle', 'Entrées', 9, true, 5),
    ('11111111-1111-1111-1111-111111111111', 'Zaalouk', 'Zaalouk daubergine et tomate', 'Entrées', 9, true, 5),
    ('11111111-1111-1111-1111-111111111111', 'Tektouka', 'Tektouka aux poivrons', 'Entrées', 9, true, 5),
    ('11111111-1111-1111-1111-111111111111', 'Sefa (entrée)', 'Sefa traditionnelle en entrée', 'Entrées', 9, true, 5),
    ('11111111-1111-1111-1111-111111111111', 'Haricot Blanc (Loubia)', 'Loubia traditionnelle', 'Entrées', 9, true, 5),
    ('11111111-1111-1111-1111-111111111111', 'Haricot Vert Mchermel', 'Haricots verts mchermel', 'Entrées', 9, true, 5),
    ('11111111-1111-1111-1111-111111111111', 'Lentilles (L3ades)', 'Lentilles traditionnelles', 'Entrées', 9, true, 5),
    ('11111111-1111-1111-1111-111111111111', 'Barba Mchermla', 'Betterave mchermla', 'Entrées', 9, true, 5),
    ('11111111-1111-1111-1111-111111111111', 'Carottes Mchermel', 'Carottes mchermel', 'Entrées', 9, true, 5),
    ('11111111-1111-1111-1111-111111111111', 'Olives Mchermel', 'Olives mchermel', 'Entrées', 9, true, 3),
    ('11111111-1111-1111-1111-111111111111', 'Pomme de terre Mchermel', 'Pommes de terre mchermel', 'Entrées', 9, true, 5),
    ('11111111-1111-1111-1111-111111111111', 'Frites au four', 'Frites cuites au four', 'Entrées', 9, true, 10);

-- ============================================================
-- 9. MENU ITEMS - SALADES
-- ============================================================
INSERT INTO menu_items (restaurant_id, name, description, category, price, is_available, prep_time_minutes) VALUES
    ('11111111-1111-1111-1111-111111111111', 'Salade Marocaine', 'Salade verte, tomate, concombre, oignon', 'Salades', 12, true, 5),
    ('11111111-1111-1111-1111-111111111111', 'Salade Niçoise', 'Tomate, pomme de terre, concombre, carotte, betterave, maïs, thon, oeuf dur, haricot vert', 'Salades', 22, true, 8),
    ('11111111-1111-1111-1111-111111111111', 'Salade Beldi Cook', 'Salade verte, tomate, pomme de terre, concombre, carotte, avocat, olive, betterave, maïs, thon, oeuf dur, haricot vert, oignon, dinde fumée, fromage', 'Salades', 40, true, 10);

-- ============================================================
-- 10. MENU ITEMS - PLATS PRINCIPAUX
-- ============================================================
INSERT INTO menu_items (restaurant_id, name, description, category, price, is_available, prep_time_minutes) VALUES
    ('11111111-1111-1111-1111-111111111111', 'Refissa au Poulet', 'Refissa traditionnelle au poulet', 'Plats Principaux', 40, true, 25),
    ('11111111-1111-1111-1111-111111111111', 'Boulette de Sardine', 'Boulettes de sardine sauce tomate', 'Plats Principaux', 40, true, 25),
    ('11111111-1111-1111-1111-111111111111', 'Plat Tqalia', 'Tqalia traditionnelle', 'Plats Principaux', 40, true, 25),
    ('11111111-1111-1111-1111-111111111111', 'Kar3in B L7amess', 'Pieds de veau aux pois chiches', 'Plats Principaux', 50, true, 45),
    ('11111111-1111-1111-1111-111111111111', 'Couscous Poulet', 'Couscous au poulet (servi avec lben - chaque vendredi)', 'Plats Principaux', 35, true, 30),
    ('11111111-1111-1111-1111-111111111111', 'Couscous Viande', 'Couscous à la viande (servi avec lben - chaque vendredi)', 'Plats Principaux', 50, true, 30),
    ('11111111-1111-1111-1111-111111111111', 'Viande aux Pruneaux (plat)', 'Viande aux pruneaux + 2 entrées au choix', 'Plats Principaux', 60, true, 45),
    ('11111111-1111-1111-1111-111111111111', 'Poulet Daghmira 1/4', '1/4 poulet à la daghmira + 2 entrées', 'Plats Principaux', 40, true, 25),
    ('11111111-1111-1111-1111-111111111111', 'Poulet Daghmira 1/2', '1/2 poulet à la daghmira + 2 entrées', 'Plats Principaux', 75, true, 30),
    ('11111111-1111-1111-1111-111111111111', 'Poulet Daghmira Entier', 'Poulet entier à la daghmira + 2 entrées', 'Plats Principaux', 140, true, 45),
    ('11111111-1111-1111-1111-111111111111', 'Pastilla Poulet (plat)', 'Pastilla individuelle au poulet', 'Plats Principaux', 42, true, 20),
    ('11111111-1111-1111-1111-111111111111', 'Pastilla Poisson (plat)', 'Pastilla individuelle au poisson', 'Plats Principaux', 48, true, 20),
    ('11111111-1111-1111-1111-111111111111', 'Tacos Pastila Poulet', 'Tacos pastilla au poulet', 'Plats Principaux', 48, true, 15),
    ('11111111-1111-1111-1111-111111111111', 'Tacos Pastila Poisson', 'Tacos pastilla au poisson', 'Plats Principaux', 58, true, 15),
    ('11111111-1111-1111-1111-111111111111', 'Sefa', 'Sefa avec 1 entrée au choix', 'Plats Principaux', 20, true, 15),
    ('11111111-1111-1111-1111-111111111111', 'Sefa Medfona', 'Sefa medfona avec 2 entrées au choix', 'Plats Principaux', 35, true, 20),
    ('11111111-1111-1111-1111-111111111111', 'Haricot Blanc avec Poulet', 'Loubia avec poulet', 'Plats Principaux', 25, true, 20),
    ('11111111-1111-1111-1111-111111111111', 'Lentilles avec Poulet', 'L3ades avec poulet', 'Plats Principaux', 25, true, 20),
    ('11111111-1111-1111-1111-111111111111', 'Tajine Poulet', 'Tajine de poulet + 2 entrées au choix', 'Plats Principaux', 40, true, 35),
    ('11111111-1111-1111-1111-111111111111', 'Tajine Poisson', 'Tajine de poisson + 2 entrées au choix', 'Plats Principaux', 50, true, 35),
    ('11111111-1111-1111-1111-111111111111', 'Tajine Viande', 'Tajine de viande + 2 entrées au choix', 'Plats Principaux', 60, true, 45);

-- ============================================================
-- 11. MENU ITEMS - PIZZAS
-- ============================================================
INSERT INTO menu_items (restaurant_id, name, description, category, price, is_available, prep_time_minutes) VALUES
    ('11111111-1111-1111-1111-111111111111', 'Pizza Thon', 'Pizza au thon', 'Pizzas', 25, true, 20),
    ('11111111-1111-1111-1111-111111111111', 'Pizza Poulet', 'Pizza au poulet', 'Pizzas', 30, true, 20),
    ('11111111-1111-1111-1111-111111111111', 'Pizza Viande Hachée', 'Pizza à la viande hachée', 'Pizzas', 35, true, 20);

-- ============================================================
-- 12. MENU ITEMS - KHBIZAT
-- ============================================================
INSERT INTO menu_items (restaurant_id, name, description, category, price, is_available, prep_time_minutes) VALUES
    ('11111111-1111-1111-1111-111111111111', 'Khbizat Poulet Daghmira', 'Khbiza poulet daghmira', 'Khbizat', 20, true, 12),
    ('11111111-1111-1111-1111-111111111111', 'Khbizat Poulet Pané', 'Khbiza poulet pané', 'Khbizat', 20, true, 12),
    ('11111111-1111-1111-1111-111111111111', 'Khbizat Viande Hachée', 'Khbiza viande hachée', 'Khbizat', 25, true, 12),
    ('11111111-1111-1111-1111-111111111111', 'Khbizat Mixte', 'Khbiza mixte', 'Khbizat', 30, true, 12);

-- ============================================================
-- 13. MENU ITEMS - SANDWICHS
-- ============================================================
INSERT INTO menu_items (restaurant_id, name, description, category, price, is_available, prep_time_minutes) VALUES
    ('11111111-1111-1111-1111-111111111111', 'Sandwich Poulet Daghmira', 'Sandwich poulet daghmira', 'Sandwichs', 30, true, 10),
    ('11111111-1111-1111-1111-111111111111', 'Sandwich Poulet Mariné', 'Sandwich poulet mariné', 'Sandwichs', 30, true, 10),
    ('11111111-1111-1111-1111-111111111111', 'Sandwich Viande Hachée', 'Sandwich viande hachée', 'Sandwichs', 35, true, 10),
    ('11111111-1111-1111-1111-111111111111', 'Sandwich Mixte', 'Sandwich mixte', 'Sandwichs', 40, true, 10);

-- ============================================================
-- 14. MENU ITEMS - TACOS
-- ============================================================
INSERT INTO menu_items (restaurant_id, name, description, category, price, is_available, prep_time_minutes) VALUES
    ('11111111-1111-1111-1111-111111111111', 'Tacos Poulet Daghmira', 'Tacos poulet daghmira', 'Tacos', 30, true, 12),
    ('11111111-1111-1111-1111-111111111111', 'Tacos Poulet Mariné', 'Tacos poulet mariné', 'Tacos', 30, true, 12),
    ('11111111-1111-1111-1111-111111111111', 'Tacos Viande Hachée', 'Tacos viande hachée', 'Tacos', 40, true, 12),
    ('11111111-1111-1111-1111-111111111111', 'Tacos Mixte', 'Tacos mixte', 'Tacos', 40, true, 12);

-- ============================================================
-- 15. MENU ITEMS - BURGERS
-- ============================================================
INSERT INTO menu_items (restaurant_id, name, description, category, price, is_available, prep_time_minutes) VALUES
    ('11111111-1111-1111-1111-111111111111', 'Cheesy Burger', 'Cheesy burger', 'Burgers', 25, true, 12),
    ('11111111-1111-1111-1111-111111111111', 'Double Cheese Burger', 'Double cheese burger', 'Burgers', 35, true, 12),
    ('11111111-1111-1111-1111-111111111111', 'Triple Cheese Burger', 'Triple cheese burger', 'Burgers', 45, true, 15);

-- ============================================================
-- 16. MENU ITEMS - BRIOUATS & CIGARES
-- ============================================================
INSERT INTO menu_items (restaurant_id, name, description, category, price, is_available, prep_time_minutes) VALUES
    ('11111111-1111-1111-1111-111111111111', 'Cigare Poulet (unité)', 'Cigare poulet à lunité', 'Briouats & Cigares', 14, true, 5),
    ('11111111-1111-1111-1111-111111111111', 'Cigare Poisson (unité)', 'Cigare poisson à lunité', 'Briouats & Cigares', 15, true, 5),
    ('11111111-1111-1111-1111-111111111111', 'Briouate Poulet (unité)', 'Briouate poulet à lunité', 'Briouats & Cigares', 12, true, 5),
    ('11111111-1111-1111-1111-111111111111', 'Briouate Poisson (unité)', 'Briouate poisson à lunité', 'Briouats & Cigares', 13, true, 5),
    ('11111111-1111-1111-1111-111111111111', 'Briouate Kefta (unité)', 'Briouate kefta à lunité', 'Briouats & Cigares', 10, true, 5),
    ('11111111-1111-1111-1111-111111111111', 'Briouate Dinde Fumée (unité)', 'Briouate dinde fumée à lunité', 'Briouats & Cigares', 10, true, 5),
    ('11111111-1111-1111-1111-111111111111', 'Briouate Fromage (unité)', 'Briouate fromage à lunité', 'Briouats & Cigares', 7, true, 5),
    ('11111111-1111-1111-1111-111111111111', 'Briouate Fromage Epinards (unité)', 'Briouate fromage epinards à lunité', 'Briouats & Cigares', 9, true, 5),
    ('11111111-1111-1111-1111-111111111111', 'Briouate Légumes (unité)', 'Briouate légumes à lunité', 'Briouats & Cigares', 6, true, 5),
    ('11111111-1111-1111-1111-111111111111', 'Box Briouats Poulet (4 ps)', 'Box de 4 briouats poulet', 'Briouats & Cigares', 40, true, 10),
    ('11111111-1111-1111-1111-111111111111', 'Box Briouats Poisson (4 ps)', 'Box de 4 briouats poisson', 'Briouats & Cigares', 45, true, 10),
    ('11111111-1111-1111-1111-111111111111', 'Box Briouats Mixte (4 ps)', 'Box de 4 briouats mixte au choix', 'Briouats & Cigares', 42, true, 10),
    ('11111111-1111-1111-1111-111111111111', 'Box Cigares Poulet (4 ps)', 'Box de 4 cigares poulet', 'Briouats & Cigares', 43, true, 10),
    ('11111111-1111-1111-1111-111111111111', 'Box Cigares Poisson (4 ps)', 'Box de 4 cigares poisson', 'Briouats & Cigares', 47, true, 10),
    ('11111111-1111-1111-1111-111111111111', 'Box Cigares Mixte (4 ps)', 'Box de 4 cigares mixte au choix', 'Briouats & Cigares', 42, true, 10),
    ('11111111-1111-1111-1111-111111111111', 'Box Beldi Cook (8 ps)', 'Cigare poulet + Cigare poisson + Briouates: poulet + poisson + kefta + fromage + fromage epinards + legumes', 'Briouats & Cigares', 80, true, 15);

-- ============================================================
-- 17. MENU ITEMS - JUS
-- ============================================================
INSERT INTO menu_items (restaurant_id, name, description, category, price, is_available, prep_time_minutes) VALUES
    ('11111111-1111-1111-1111-111111111111', 'Jus Betterave', 'Jus de betterave frais', 'Jus', 13, true, 3),
    ('11111111-1111-1111-1111-111111111111', 'Jus Concombre', 'Jus de concombre frais', 'Jus', 13, true, 3),
    ('11111111-1111-1111-1111-111111111111', 'Jus Carotte', 'Jus de carotte frais', 'Jus', 13, true, 3),
    ('11111111-1111-1111-1111-111111111111', 'Jus Citron', 'Jus de citron frais', 'Jus', 13, true, 3),
    ('11111111-1111-1111-1111-111111111111', 'Jus Orange', 'Jus dorange frais', 'Jus', 15, true, 3),
    ('11111111-1111-1111-1111-111111111111', 'Jus Pomme', 'Jus de pomme frais', 'Jus', 15, true, 3),
    ('11111111-1111-1111-1111-111111111111', 'Jus Banane', 'Jus de banane frais', 'Jus', 15, true, 3),
    ('11111111-1111-1111-1111-111111111111', 'Jus Framboise', 'Jus de framboise frais', 'Jus', 18, true, 3),
    ('11111111-1111-1111-1111-111111111111', 'Jus Fraise', 'Jus de fraise frais', 'Jus', 18, true, 3),
    ('11111111-1111-1111-1111-111111111111', 'Jus Ananas', 'Jus dananas frais', 'Jus', 18, true, 3),
    ('11111111-1111-1111-1111-111111111111', 'Jus Kiwi', 'Jus de kiwi frais', 'Jus', 20, true, 3),
    ('11111111-1111-1111-1111-111111111111', 'Jus Panaché', 'Jus panaché de fruits', 'Jus', 20, true, 5),
    ('11111111-1111-1111-1111-111111111111', 'Jus Mangue', 'Jus de mangue frais', 'Jus', 20, true, 3),
    ('11111111-1111-1111-1111-111111111111', 'Jus Avocat', 'Jus davocat frais', 'Jus', 20, true, 3),
    ('11111111-1111-1111-1111-111111111111', 'Jus Avocat Fruits Secs', 'Jus davocat aux fruits secs', 'Jus', 25, true, 5),
    ('11111111-1111-1111-1111-111111111111', 'Salade de Fruits', 'Salade de fruits frais', 'Jus', 20, true, 5);

-- ============================================================
-- 18. MENU ITEMS - DESSERTS
-- ============================================================
INSERT INTO menu_items (restaurant_id, name, description, category, price, is_available, prep_time_minutes) VALUES
    ('11111111-1111-1111-1111-111111111111', 'Cake Maison (morceau)', 'Morceau de cake maison', 'Desserts', 20, true, 2);

-- ============================================================
-- VERIFICATION
-- ============================================================
-- Count menu items per category
DO $$
DECLARE
    total_items INT;
    total_ingredients INT;
BEGIN
    SELECT COUNT(*) INTO total_items FROM menu_items 
    WHERE restaurant_id = '11111111-1111-1111-1111-111111111111';
    
    SELECT COUNT(*) INTO total_ingredients FROM ingredients 
    WHERE restaurant_id = '11111111-1111-1111-1111-111111111111';
    
    RAISE NOTICE '✅ Beldi Cook Menu Imported!';
    RAISE NOTICE '📦 Total menu items: %', total_items;
    RAISE NOTICE '🥬 Total ingredients: %', total_ingredients;
END $$;

-- Show summary by category
SELECT 
    category,
    COUNT(*) AS items,
    MIN(price) AS prix_min,
    MAX(price) AS prix_max,
    ROUND(AVG(price)::numeric, 2) AS prix_moyen
FROM menu_items
WHERE restaurant_id = '11111111-1111-1111-1111-111111111111'
GROUP BY category
ORDER BY category;
