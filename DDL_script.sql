CREATE TABLE customer (
    customer_id SERIAL PRIMARY KEY,
    nickname    VARCHAR(50) NOT NULL,
    password    VARCHAR(50) NOT NULL
);

CREATE TABLE "order" (
    order_id    SERIAL PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date  DATE NOT NULL
);

CREATE TABLE order_item (
    order_item_id SERIAL PRIMARY KEY,
    order_id      INT NOT NULL,
    game_id       INT NOT NULL,
    copies_count  INT NOT NULL CHECK (copies_count > 0)
);

CREATE TABLE game (
    game_id       SERIAL PRIMARY KEY,
    developer_id  INT NOT NULL,
    title         VARCHAR(50) NOT NULL,
    release_date  DATE,
    price         INT NOT NULL
);

CREATE TABLE developer (
    developer_id      SERIAL PRIMARY KEY,
    name              VARCHAR(50) NOT NULL,
    registration_date DATE NOT NULL
);

ALTER TABLE "order"
  ADD CONSTRAINT fk_order_customer
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id);

ALTER TABLE order_item
  ADD CONSTRAINT fk_order_item_order
    FOREIGN KEY (order_id) REFERENCES "order"(order_id);

ALTER TABLE order_item
  ADD CONSTRAINT fk_order_item_game
    FOREIGN KEY (game_id) REFERENCES game(game_id);

ALTER TABLE game
  ADD CONSTRAINT fk_game_developer
    FOREIGN KEY (developer_id) REFERENCES developer(developer_id);

COMMENT ON COLUMN game.release_date   IS 'Дата официального релиза игры';
COMMENT ON COLUMN game.price          IS 'Цена за единицу игры';
COMMENT ON COLUMN developer.registration_date IS 'Дата регистрации разработчика';
