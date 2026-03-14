-- ============================================================
--  3_insertion.sql
--  Sample Data Insertion
--  Generated with AI assistance.
--
--  PROMPT USED:
--  "You are a SQL data generator, you must help me for a textile retail database.
--   Generate realistic INSERT statements for the following tables in order
--   (respecting foreign key dependencies):
--   headquarters, material, selling_type, client, payment, store, employee,
--   item, order_, is_made_of, belongs_to, has, contains, paid.
--   Rules:
--   - Generate at least 5 rows per table, more for junction tables.
--   - All values must be consistent with each other (FK values must exist).
--   - Respect all CHECK constraints: prices > 0, emails contain '@',
--     order must be physical XOR online, status in known list, etc.
--   - The context is a yarn/fabric/textile retail brand with physical and online stores.
--   - Return only valid SQL INSERT statements, no commentary."
-- ============================================================

-- ============================================================
--  headquarters
-- ============================================================
INSERT INTO headquarters (name) VALUES
    ('Paris HQ'),
    ('Lyon HQ'),
    ('Bordeaux HQ');

-- ============================================================
--  material
-- ============================================================
INSERT INTO material (material_id, material_name) VALUES
    (1,  'Cotton'),
    (2,  'Wool'),
    (3,  'Silk'),
    (4,  'Linen'),
    (5,  'Polyester'),
    (6,  'Cashmere'),
    (7,  'Nylon'),
    (8,  'Alpaca'),
    (9,  'Bamboo'),
    (10, 'Acrylic');

-- ============================================================
--  selling_type
-- ============================================================
INSERT INTO selling_type (ST_amount, ST_weight, ST_length, ST_yarn_weight, ST_yarn_ply, ST_fabric_weave) VALUES
    (1,    NULL,  NULL,  NULL,  NULL, NULL),          -- 1: sold by unit
    (NULL, 100,   NULL,  NULL,  NULL, NULL),          -- 2: 100g skein
    (NULL, 200,   NULL,  NULL,  NULL, NULL),          -- 3: 200g skein
    (NULL, NULL,  1.00,  NULL,  NULL, NULL),          -- 4: 1 metre of fabric
    (NULL, NULL,  NULL,  NULL,  NULL, 'plain weave'), -- 5: fabric by weave type
    (NULL, NULL,  NULL,  4.00,  NULL, NULL),          -- 6: DK weight yarn
    (NULL, NULL,  NULL,  NULL,  4,    NULL),          -- 7: 4-ply yarn
    (NULL, NULL,  NULL,  8.00,  NULL, NULL),          -- 8: Aran weight yarn
    (NULL, 50,    NULL,  NULL,  NULL, NULL),          -- 9: 50g skein
    (5,    NULL,  NULL,  NULL,  NULL, NULL);          -- 10: sold in pack of 5

-- ============================================================
--  client
-- ============================================================
INSERT INTO client (c_id, c_first_last_name, c_adress, c_tel_number, c_email_adress, member_loyalty_prgm) VALUES
    (1,  'Alice Martin',     '12 Rue de la Paix, Paris',          '+33 6 12 34 56 78', 'alice.martin@email.fr',     TRUE),
    (2,  'Bruno Leclerc',    '45 Avenue Gambetta, Lyon',          '+33 7 23 45 67 89', 'bruno.leclerc@email.fr',    FALSE),
    (3,  'Clara Dupont',     '8 Rue Saint-Michel, Bordeaux',      '+33 6 34 56 78 90', 'clara.dupont@email.fr',     TRUE),
    (4,  'David Morel',      '3 Place des Terreaux, Lyon',        '+33 6 45 67 89 01', 'david.morel@email.fr',      FALSE),
    (5,  'Emma Rousseau',    '77 Boulevard Haussmann, Paris',     '+33 7 56 78 90 12', 'emma.rousseau@email.fr',    TRUE),
    (6,  'François Petit',   '22 Rue Victor Hugo, Bordeaux',      '+33 6 67 89 01 23', 'francois.petit@email.fr',   FALSE),
    (7,  'Gabrielle Simon',  '5 Rue Lafayette, Paris',            '+33 7 78 90 12 34', 'gabrielle.simon@email.fr',  TRUE),
    (8,  'Hugo Bernard',     '14 Cours de la Liberté, Lyon',      '+33 6 89 01 23 45', 'hugo.bernard@email.fr',     FALSE),
    (9,  'Isabelle Thomas',  '30 Allée des Roses, Bordeaux',      '+33 6 90 12 34 56', 'isabelle.thomas@email.fr',  TRUE),
    (10, 'Julien Robert',    '1 Rue du Faubourg, Paris',          '+33 7 01 23 45 67', 'julien.robert@email.fr',    FALSE);

-- ============================================================
--  payment
-- ============================================================
INSERT INTO payment (payement_id, payement_date, amount, method) VALUES
    (1,  '2024-01-15', 45.00,  'credit_card'),
    (2,  '2024-02-03', 120.50, 'paypal'),
    (3,  '2024-02-18', 78.99,  'credit_card'),
    (4,  '2024-03-07', 200.00, 'bank_transfer'),
    (5,  '2024-03-22', 34.50,  'cash'),
    (6,  '2024-04-10', 67.00,  'debit_card'),
    (7,  '2024-05-05', 155.25, 'credit_card'),
    (8,  '2024-06-14', 89.99,  'paypal'),
    (9,  '2024-07-01', 44.00,  'gift_card'),
    (10, '2024-08-20', 310.00, 'credit_card'),
    (11, '2024-09-03', 22.50,  'cash'),
    (12, '2024-10-11', 95.00,  'debit_card'),
    (13, '2024-11-25', 180.75, 'credit_card'),
    (14, '2025-01-08', 60.00,  'paypal'),
    (15, '2025-02-14', 249.99, 'bank_transfer');

-- ============================================================
--  store
-- ============================================================
INSERT INTO store (store_id, store_location, hq_name) VALUES
    (1, 'Paris - Marais',         'Paris HQ'),
    (2, 'Paris - Montmartre',     'Paris HQ'),
    (3, 'Lyon - Bellecour',       'Lyon HQ'),
    (4, 'Lyon - Part-Dieu',       'Lyon HQ'),
    (5, 'Bordeaux - Centre',      'Bordeaux HQ'),
    (6, 'Online Store',           'Paris HQ');

-- ============================================================
--  employee
--  First insert managers (manager_id = NULL), then managed employees
-- ============================================================
INSERT INTO employee (E_id, E_first_last_name, role, store_id, manager_id) VALUES
    -- Managers (no manager above them)
    (1,  'Sophie Lambert',    'Store Manager',    1, NULL),
    (2,  'Pierre Durand',     'Store Manager',    2, NULL),
    (3,  'Anne Fontaine',     'Store Manager',    3, NULL),
    (4,  'Marc Girard',       'Store Manager',    4, NULL),
    (5,  'Lucie Bonnet',      'Store Manager',    5, NULL),
    (6,  'Théo Mercier',      'Store Manager',    6, NULL);

INSERT INTO employee (E_id, E_first_last_name, role, store_id, manager_id) VALUES
    -- Staff managed by store managers
    (7,  'Nina Chevalier',    'Sales Associate',  1, 1),
    (8,  'Romain Blanc',      'Sales Associate',  1, 1),
    (9,  'Camille Garnier',   'Cashier',          2, 2),
    (10, 'Antoine Leroy',     'Sales Associate',  2, 2),
    (11, 'Pauline Renard',    'Sales Associate',  3, 3),
    (12, 'Maxime Faure',      'Cashier',          3, 3),
    (13, 'Céline Morin',      'Sales Associate',  4, 4),
    (14, 'Bastien Giraud',    'Warehouse Staff',  4, 4),
    (15, 'Laura Perez',       'Sales Associate',  5, 5);

-- ============================================================
--  item
--  9 yarn/crochet products, 3 accessories/notions, 3 clothing
-- ============================================================
INSERT INTO item (I_id, I_name, I_category, I_price, I_color_or_pattern, brand) VALUES
    (1,  'Merino Wool Skein 100g',       'Yarn',       12.99, 'Cream',          'YarnCo'),
    (2,  'Alpaca Blend Skein 200g',      'Yarn',       18.50, 'Grey',           'AlpacaFarm'),
    (3,  'Bamboo Baby Yarn 50g',         'Yarn',        9.99, 'Soft Yellow',    'YarnCo'),
    (4,  'Acrylic Yarn Skein 100g',      'Yarn',        5.50, 'Multicolour',    'CraftYarn'),
    (5,  'Cotton Crochet Thread 200m',   'Yarn',        7.99, 'White',          'CraftYarn'),
    (6,  'Chunky Wool Skein 200g',       'Yarn',       14.99, 'Rust Orange',    'WoolCraft'),
    (7,  'Cashmere Lace Yarn 50g',       'Yarn',       22.50, 'Ivory',          'LuxeTextile'),
    (8,  'Mohair Silk Yarn 25g',         'Yarn',       16.99, 'Dusty Rose',     'LuxeTextile'),
    (9,  'Recycled Cotton Yarn 100g',    'Yarn',        8.99, 'Denim Blue',     'EcoYarn'),
    (10, 'Crochet Hook Set',             'Accessory',  19.99, 'Multicolour',    'CraftTools'),
    (11, 'Bamboo Knitting Needles Set',  'Accessory',  14.50, 'Natural',        'CraftTools'),
    (12, 'Stitch Markers Pack x50',      'Accessory',   6.99, 'Assorted',       'CraftTools'),
    (13, 'Hand-Knit Wool Beanie',        'Accessory',  29.99, 'Forest Green',   'WoolCraft'),
    (14, 'Knitted Wool Cardigan',        'Top',        89.00, 'Oatmeal',        'WoolCraft'),
    (15, 'Crochet Cotton Summer Top',    'Top',        45.00, 'Terracotta',     'EcoYarn');

-- ============================================================
--  order_
-- ============================================================
INSERT INTO order_ (order_id, physical, online, refund, Total_price, delivery, status, c_id) VALUES
    (1,  TRUE,  FALSE, FALSE,  25.98, NULL,                    'delivered',  1),
    (2,  FALSE, TRUE,  FALSE,  49.48, '12 Rue de la Paix',     'delivered',  2),
    (3,  TRUE,  FALSE, FALSE,  28.48, NULL,                    'delivered',  3),
    (4,  FALSE, TRUE,  FALSE,  89.00, '3 Place des Terreaux',  'shipped',    4),
    (5,  TRUE,  FALSE, FALSE,  17.98, NULL,                    'delivered',  5),
    (6,  FALSE, TRUE,  FALSE,  52.48, '77 Bd Haussmann',       'confirmed',  5),
    (7,  TRUE,  FALSE, FALSE,  31.48, NULL,                    'delivered',  6),
    (8,  FALSE, TRUE,  FALSE,  22.50, '22 Rue Victor Hugo',    'delivered',  7),
    (9,  TRUE,  FALSE, FALSE,  19.99, NULL,                    'cancelled',  8),
    (10, FALSE, TRUE,  FALSE, 108.48, '30 Allée des Roses',    'delivered',  9),
    (11, TRUE,  FALSE, FALSE,  12.99, NULL,                    'delivered',  10),
    (12, FALSE, TRUE,  FALSE,  34.48, '1 Rue du Faubourg',     'pending',    1),
    (13, TRUE,  FALSE, FALSE,  51.97, NULL,                    'delivered',  3),
    (14, FALSE, TRUE,  FALSE,  31.48, '45 Avenue Gambetta',    'delivered',  2),
    (15, FALSE, TRUE,  TRUE,   45.00, '8 Rue Saint-Michel',    'refunded',   3);

-- ============================================================
--  is_made_of (item × material)
-- ============================================================
INSERT INTO is_made_of (I_id, material_id) VALUES
    (1,  2),   -- Merino Wool Skein → Wool
    (2,  2),   -- Alpaca Blend Skein → Wool
    (2,  8),   -- Alpaca Blend Skein → Alpaca
    (3,  9),   -- Bamboo Baby Yarn → Bamboo
    (4,  10),  -- Acrylic Yarn Skein → Acrylic
    (5,  1),   -- Cotton Crochet Thread → Cotton
    (6,  2),   -- Chunky Wool Skein → Wool
    (7,  6),   -- Cashmere Lace Yarn → Cashmere
    (8,  2),   -- Mohair Silk Yarn → Wool
    (8,  3),   -- Mohair Silk Yarn → Silk
    (9,  1),   -- Recycled Cotton Yarn → Cotton
    (13, 2),   -- Hand-Knit Wool Beanie → Wool
    (14, 2),   -- Knitted Wool Cardigan → Wool
    (15, 1);   -- Crochet Cotton Summer Top → Cotton

-- ============================================================
--  belongs_to (item × selling_type)
-- ============================================================
INSERT INTO belongs_to (I_id, ST_id) VALUES
    (1,  2),   -- Merino Wool Skein 100g → 100g skein
    (2,  3),   -- Alpaca Blend Skein 200g → 200g skein
    (3,  9),   -- Bamboo Baby Yarn 50g → 50g skein
    (4,  2),   -- Acrylic Yarn Skein 100g → 100g skein
    (5,  1),   -- Cotton Crochet Thread → by unit
    (6,  3),   -- Chunky Wool Skein 200g → 200g skein
    (7,  9),   -- Cashmere Lace Yarn 50g → 50g skein
    (7,  7),   -- Cashmere Lace Yarn → 4-ply
    (8,  9),   -- Mohair Silk Yarn 25g → 50g skein (closest)
    (8,  6),   -- Mohair Silk Yarn → DK weight
    (9,  2),   -- Recycled Cotton Yarn 100g → 100g skein
    (10, 1),   -- Crochet Hook Set → by unit
    (11, 1),   -- Knitting Needles Set → by unit
    (12, 10),  -- Stitch Markers Pack → pack of 5
    (13, 1),   -- Hand-Knit Wool Beanie → by unit
    (14, 1),   -- Knitted Wool Cardigan → by unit
    (15, 1);   -- Crochet Cotton Summer Top → by unit

-- ============================================================
--  has (store × item, with disponibility = stock qty)
-- ============================================================
INSERT INTO has (store_id, I_id, disponibility) VALUES
    (1, 1,  40), (1, 2,  20), (1, 4,  60), (1, 6,  25), (1, 10, 15),
    (2, 1,  35), (2, 3,  50), (2, 5,  30), (2, 7,  10), (2, 11, 20),
    (3, 1,  45), (3, 2,  18), (3, 4,  70), (3, 8,  12), (3, 12, 40),
    (4, 3,  55), (4, 6,  22), (4, 9,  35), (4, 10, 18), (4, 13, 15),
    (5, 1,  30), (5, 4,  65), (5, 5,  25), (5, 11, 22), (5, 14, 8),
    (6, 1,  200),(6, 2,  150),(6, 3,  180),(6, 4,  250),(6, 5,  120),
    (6, 6,  160),(6, 7,   80),(6, 8,   90),(6, 9,  200),(6, 10,  60),
    (6, 11,  70),(6, 12, 100),(6, 13,  50),(6, 14,  30),(6, 15,  40);

-- ============================================================
--  contains (order × item)
-- ============================================================
INSERT INTO contains (I_id, order_id) VALUES
    (1,  1),  (4,  1),
    (2,  2),  (3,  2),
    (4,  3),  (9,  3),
    (14, 4),
    (3,  5),  (5,  5),
    (6,  6),  (4,  6),  (12, 6),
    (8,  7),  (3,  7),
    (7,  8),
    (10, 9),
    (1,  10), (2,  10), (6,  10),
    (1,  11),
    (4,  12), (3,  12),
    (1,  13), (4,  13), (5,  13),
    (2,  14), (8,  14),
    (15, 15);

-- ============================================================
--  paid (order × payment)
-- ============================================================
INSERT INTO paid (order_id, payement_id) VALUES
    (1,  1),
    (2,  2),
    (3,  3),
    (4,  4),
    (5,  5),
    (6,  6),
    (7,  7),
    (8,  8),
    (9,  9),
    (10, 10),
    (11, 11),
    (12, 12),
    (13, 13),
    (14, 14),
    (15, 15);
