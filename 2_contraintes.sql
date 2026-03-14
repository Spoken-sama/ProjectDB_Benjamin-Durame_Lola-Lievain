--  Validation Constraints 

--  client :


-- Email must follow a basic pattern (contains @ and a dot after it)
ALTER TABLE client
    ADD CONSTRAINT chk_client_email
    CHECK (c_email_adress IS NULL
        OR c_email_adress LIKE '%@%.%');

-- Phone number: digits, spaces, +, -, parentheses only; max 20 chars
ALTER TABLE client
    ADD CONSTRAINT chk_client_tel
    CHECK (c_tel_number IS NULL
        OR c_tel_number REGEXP '^[+]?[0-9 ()\\-]{5,20}$');

-- Name must not be empty/blank
ALTER TABLE client
    ADD CONSTRAINT chk_client_name
    CHECK (TRIM(c_first_last_name) <> '');


--  item :


-- Price must be strictly positive
ALTER TABLE item
    ADD CONSTRAINT chk_item_price
    CHECK (I_price > 0);

-- Name must not be empty/blank
ALTER TABLE item
    ADD CONSTRAINT chk_item_name
    CHECK (TRIM(I_name) <> '');

-- Category: restrict to known textile categories
ALTER TABLE item
    ADD CONSTRAINT chk_item_category
    CHECK (I_category IS NULL OR I_category IN (
        'Top', 'Bottom', 'Dress', 'Outerwear', 'Underwear',
        'Accessory', 'Footwear', 'Sportswear', 'Fabric', 'Yarn', 'Other'
    ));

--  selling_type :

-- Amount must be positive if set
ALTER TABLE selling_type
    ADD CONSTRAINT chk_st_amount
    CHECK (ST_amount IS NULL OR ST_amount > 0);

-- Weight must be positive if set
ALTER TABLE selling_type
    ADD CONSTRAINT chk_st_weight
    CHECK (ST_weight IS NULL OR ST_weight > 0);

-- Length must be positive if set
ALTER TABLE selling_type
    ADD CONSTRAINT chk_st_length
    CHECK (ST_length IS NULL OR ST_length > 0);

-- Yarn weight must be positive if set
ALTER TABLE selling_type
    ADD CONSTRAINT chk_st_yarn_weight
    CHECK (ST_yarn_weight IS NULL OR ST_yarn_weight > 0);

-- Yarn ply must be positive if set
ALTER TABLE selling_type
    ADD CONSTRAINT chk_st_yarn_ply
    CHECK (ST_yarn_ply IS NULL OR ST_yarn_ply > 0);

-- At least one selling attribute must be specified
ALTER TABLE selling_type
    ADD CONSTRAINT chk_st_at_least_one
    CHECK (
        ST_amount IS NOT NULL OR
        ST_weight IS NOT NULL OR
        ST_length IS NOT NULL OR
        ST_yarn_weight IS NOT NULL OR
        ST_yarn_ply IS NOT NULL OR
        ST_fabric_weave IS NOT NULL
    );

--  order_ : 

-- Total price must be positive
ALTER TABLE order_
    ADD CONSTRAINT chk_order_price
    CHECK (Total_price >= 0);

-- Status restricted to known values
ALTER TABLE order_
    ADD CONSTRAINT chk_order_status
    CHECK (status IN ('pending', 'confirmed', 'shipped', 'delivered', 'cancelled', 'refunded'));

-- An order must be either physical or online, not both, not neither
ALTER TABLE order_
    ADD CONSTRAINT chk_order_channel
    CHECK (
        (physical = TRUE AND online = FALSE) OR
        (physical = FALSE AND online = TRUE)
    );

-- A refund can only exist if the order status is 'refunded'
ALTER TABLE order_
    ADD CONSTRAINT chk_order_refund_status
    CHECK (
        refund = FALSE OR status = 'refunded'
    );

--  payment :

-- Amount must be strictly positive
ALTER TABLE payment
    ADD CONSTRAINT chk_payment_amount
    CHECK (amount > 0);

-- Method must be a known payment type
ALTER TABLE payment
    ADD CONSTRAINT chk_payment_method
    CHECK (method IN ('cash', 'credit_card', 'debit_card', 'paypal', 'bank_transfer', 'gift_card'));


--  has (store stocks item) :
 

-- Stock quantity must be zero or positive
ALTER TABLE has
    ADD CONSTRAINT chk_has_disponibility
    CHECK (disponibility IS NULL OR disponibility >= 0);


--  employee :


-- Role must not be empty/blank
ALTER TABLE employee
    ADD CONSTRAINT chk_employee_role
    CHECK (TRIM(role) <> '');



--  material :


-- Material name must not be empty/blank
ALTER TABLE material
    ADD CONSTRAINT chk_material_name
    CHECK (TRIM(material_name) <> '');


--  store :


-- Location must not be empty/blank
ALTER TABLE store
    ADD CONSTRAINT chk_store_location
    CHECK (TRIM(store_location) <> '');
