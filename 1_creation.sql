Create database IF NOT EXISTS the_yarn_compagny ;
use the_yarn_compagny;
 
CREATE TABLE headquarters (
    name VARCHAR(100) NOT NULL,
    CONSTRAINT pk_headquarters PRIMARY KEY (name)
);
 
CREATE TABLE material (
    material_id   INT          NOT NULL,
    material_name VARCHAR(100) NOT NULL,
    CONSTRAINT pk_material PRIMARY KEY (material_id)
);
 
CREATE TABLE selling_type (
    ST_id           INT          NOT NULL AUTO_INCREMENT,
    ST_amount       INT,
    ST_weight       DECIMAL(8,2),
    ST_length       DECIMAL(8,2),
    ST_yarn_weight  DECIMAL(8,2),
    ST_yarn_ply     INT,
    ST_fabric_weave VARCHAR(100),
    CONSTRAINT pk_selling_type PRIMARY KEY (ST_id)
);
 
CREATE TABLE client (
    c_id                INT          NOT NULL,
    c_first_last_name   VARCHAR(150) NOT NULL,
    c_adress            VARCHAR(255),
    c_tel_number        VARCHAR(20),
    c_email_adress      VARCHAR(150),
    member_loyalty_prgm BOOLEAN      NOT NULL DEFAULT FALSE,
    CONSTRAINT pk_client PRIMARY KEY (c_id)
);
 
CREATE TABLE payment (
    payement_id   INT          NOT NULL,
    payement_date DATE         NOT NULL,
    amount        DECIMAL(10,2) NOT NULL,
    method        VARCHAR(50)  NOT NULL,
    CONSTRAINT pk_payment PRIMARY KEY (payement_id)
);

 
CREATE TABLE store (
    store_id       INT          NOT NULL,
    store_location VARCHAR(255) NOT NULL,
    hq_name        VARCHAR(100) NOT NULL,
    CONSTRAINT pk_store       PRIMARY KEY (store_id),
    CONSTRAINT fk_store_hq    FOREIGN KEY (hq_name)
        REFERENCES headquarters(name)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

 
CREATE TABLE employee (
    E_id             INT          NOT NULL,
    E_first_last_name VARCHAR(150) NOT NULL,
    role             VARCHAR(100) NOT NULL,
    store_id         INT          NOT NULL,
    manager_id       INT,                    
    CONSTRAINT pk_employee        PRIMARY KEY (E_id),
    CONSTRAINT fk_employee_store  FOREIGN KEY (store_id)
        REFERENCES store(store_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT fk_employee_manager FOREIGN KEY (manager_id)
        REFERENCES employee(E_id)
        ON UPDATE CASCADE
        ON DELETE SET NULL
);
 
 
CREATE TABLE item (
    I_id             INT           NOT NULL,
    I_name           VARCHAR(150)  NOT NULL,
    I_category       VARCHAR(100),
    I_price          DECIMAL(10,2) NOT NULL,
    I_color_or_pattern VARCHAR(100),
    brand            VARCHAR(100),
    CONSTRAINT pk_item PRIMARY KEY (I_id)
);
 
CREATE TABLE order_ (
    order_id    INT           NOT NULL,
    physical    BOOLEAN       NOT NULL DEFAULT FALSE,
    online      BOOLEAN       NOT NULL DEFAULT FALSE,
    refund      BOOLEAN       NOT NULL DEFAULT FALSE,
    Total_price DECIMAL(10,2) NOT NULL,
    delivery    VARCHAR(255),
    status      VARCHAR(50)   NOT NULL,
    c_id        INT           NOT NULL,
    CONSTRAINT pk_order    PRIMARY KEY (order_id),
    CONSTRAINT fk_order_client FOREIGN KEY (c_id)
        REFERENCES client(c_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
); 
 
CREATE TABLE is_made_of (
    I_id        INT NOT NULL,
    material_id INT NOT NULL,
    CONSTRAINT pk_is_made_of     PRIMARY KEY (I_id, material_id),
    CONSTRAINT fk_iof_item       FOREIGN KEY (I_id)
        REFERENCES item(I_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_iof_material   FOREIGN KEY (material_id)
        REFERENCES material(material_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);
 
CREATE TABLE belongs_to (
    I_id   INT NOT NULL,
    ST_id  INT NOT NULL,
    CONSTRAINT pk_belongs_to   PRIMARY KEY (I_id, ST_id),
    CONSTRAINT fk_bt_item      FOREIGN KEY (I_id)
        REFERENCES item(I_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_bt_st        FOREIGN KEY (ST_id)
        REFERENCES selling_type(ST_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);
 
CREATE TABLE has (
    store_id     INT     NOT NULL,
    I_id         INT     NOT NULL,
    disponibility INT,
    CONSTRAINT pk_has      PRIMARY KEY (store_id, I_id),
    CONSTRAINT fk_has_store FOREIGN KEY (store_id)
        REFERENCES store(store_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_has_item  FOREIGN KEY (I_id)
        REFERENCES item(I_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);
 
CREATE TABLE contains (
    I_id     INT NOT NULL,
    order_id INT NOT NULL,
    CONSTRAINT pk_contains      PRIMARY KEY (I_id, order_id),
    CONSTRAINT fk_cont_item     FOREIGN KEY (I_id)
        REFERENCES item(I_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT fk_cont_order    FOREIGN KEY (order_id)
        REFERENCES order_(order_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);
 
CREATE TABLE paid (
    order_id    INT NOT NULL,
    payement_id INT NOT NULL,
    CONSTRAINT pk_paid           PRIMARY KEY (order_id, payement_id),
    CONSTRAINT fk_paid_order     FOREIGN KEY (order_id)
        REFERENCES order_(order_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_paid_payment   FOREIGN KEY (payement_id)
        REFERENCES payment(payement_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);