USE Restaurant;

SHOW TABLES;

CREATE TABLE menu(
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    item_name VARCHAR(100) NOT NULL,
    item_description VARCHAR(255) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    category VARCHAR(100) NOT NULL
);

CREATE TABLE customers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone_number VARCHAR(100) NOT NULL
);

CREATE TABLE tables (
    id INT AUTO_INCREMENT PRIMARY KEY,
    capacity INT NOT NULL,
    status VARCHAR(100) NOT NULL
);

CREATE TABLE orders(
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    table_id INT NOT NULL,
    customer_id INT NOT NULL,
    order_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    order_status VARCHAR(100) NOT NULL,
    FOREIGN KEY (table_id) REFERENCES tables(id),
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);

CREATE TABLE order_item (
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    menu_item_id INT NOT NULL,
    quantity INT NOT NULL,  
    special_request VARCHAR(255),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (menu_item_id) REFERENCES menu(item_id)
);

CREATE TABLE robot(
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    status VARCHAR(100) NOT NULL
);

CREATE TABLE employee(
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone_number VARCHAR(100) NOT NULL,
    position VARCHAR(100) NOT NULL,
    status VARCHAR(100) NOT NULL
);



USE Restaurant; -- Replace 'restaurant_database' with your actual database name

-- Table: menu
INSERT INTO menu (item_name, item_description, price, category) VALUES 
('Classic Burger', 'Juicy beef patty, lettuce, tomato, onion, pickles', 12.50, 'Burgers'),
('Veggie Delight', 'Plant-based patty, avocado, sprouts, vegan cheese', 13.00, 'Burgers'),
('Fried Chicken', 'Crispy buttermilk fried chicken, coleslaw ', 10.95, 'Mains'),
('Garden Salad', 'Mixed greens, cucumbers, tomatoes, house vinaigrette', 8.50, 'Starters'),
('Caesar Salad', 'Romaine, parmesan, croutons, classic Caesar dressing', 9.95, 'Starters'),
('Chocolate Cake', 'Rich chocolate cake, whipped cream', 7.50, 'Desserts'),
('Apple Pie', 'Warm apple pie, à la mode', 6.95, 'Desserts');

-- Table: customers
INSERT INTO customers (first_name, last_name, email, phone_number) VALUES
('Jane', 'Doe', 'jane.doe@email.com', '555-123-4567'),
('John', 'Smith', 'john.smith@email.com', '555-234-5678'),
('Sarah', 'Johnson', 'sjohnson@email.com', '555-345-6789');

-- Table: tables
INSERT INTO tables (capacity, status) VALUES
(2, 'Available'),
(4, 'Occupied'),
(6, 'Available'),
(2, 'Available');

-- Table: orders
INSERT INTO orders (table_id, customer_id, order_status) VALUES
(2, 1, 'Completed'),
(3, 2, 'In Progress');

-- Table: order_item
INSERT INTO order_item (order_id, menu_item_id, quantity, special_request) VALUES
(1, 1, 1, 'No pickles'),
(1, 4, 1, NULL), 
(2, 2, 2, 'Extra sauce on the side'),
(2, 6, 1, NULL); 

-- Table: robot
INSERT INTO robot (name, status) VALUES
('Rosie', 'Available'),
('Rusty', 'In Service');

-- Table: employee
INSERT INTO employee (first_name, last_name, email, phone_number, position, status) VALUES
('Emily', 'Parker', '[email address removed]', '555-678-9012', 'Server', 'Active'),
('Michael', 'Wilson', '[email address removed]', '555-101-1212', 'Chef', 'Active'),
('Olivia', 'Thompson', '[email address removed]', '555-543-2109', 'Hostess', 'Active');
