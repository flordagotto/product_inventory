INSERT INTO product (product_name, product_description, price) VALUES
('Laptop', 'Powerful laptop with high-performance specs', 1200.00),
('Smartphone', 'Latest model with advanced features', 800.00),
('Headphones', 'Noise-canceling headphones for immersive audio', 150.00),
('Camera', 'Professional-grade camera', 900.00),
('Tablet', 'Portable device for on-the-go computing', 350.00),
('Smartwatch', 'Wearable technology for fitness and notifications', 200.00),
('Wireless Mouse', 'Ergonomic mouse for comfortable computing', 30.00),
('4K TV', 'High-resolution television', 1000.00),
('Gaming Laptop', 'Powerful laptop designed for gaming enthusiasts', 1500.00),
('Bluetooth Speaker', 'Portable speaker for wireless audio streaming', 80.00),
('External Hard Drive', 'Storage solution for backing up and expanding data', 120.00),
('Fitness Tracker', 'Track your daily activities and health metrics', 60.00),
('Wireless Keyboard', 'Convenient keyboard for wire-free typing', 40.00),
('Drones', 'Remote-controlled aerial devices for photography', 700.00),
('VR Headset', 'Immersive experience in virtual worlds', 300.00),
('Printer', 'High-quality printer for documents and photos', 180.00),
('Action Camera', 'Compact camera for capturing action-packed moments', 250.00),
('Computer Monitor', 'Large display for enhanced productivity', 400.00),
('Power Bank', 'Portable charger for mobile devices', 25.00);


INSERT INTO category (category_name, category_description) VALUES
('Electronics', 'Devices and gadgets powered by technology'),
('Accessories', 'Additional items to enhance user experience'),
('Photography', 'Equipment for capturing and preserving memories'),
('Home Electronics', 'Devices for entertainment and productivity at home'),
('Gadgets', 'Small and innovative devices for various purposes'),
('Office Accessories', 'Items to enhance efficiency in a work environment'),
('Televisions', 'High-quality displays for immersive entertainment'),
('Gaming', 'Products tailored for gaming enthusiasts'),
('Audio', 'Devices for high-quality sound experiences'),
('Storage', 'Solutions for data backup and organization'),
('Wearables', 'Technological devices worn as accessories'),
('Peripherals', 'External devices to complement computer systems'),
('Virtual Reality', 'Products providing an immersive virtual exp'),
('Printers', 'Devices for producing physical copies of documents'),
('Cameras', 'Devices for capturing images and recording videos'),
('Computer Displays', 'Monitors for computers and workstations'),
('Mobile Accessories', 'Products for mobile devices');

INSERT INTO products_per_category (product_id, category_id) VALUES
(1, 1), -- Laptop belongs to Electronics
(2, 1), -- Smartphone belongs to Electronics
(2, 5), -- Smartphone belongs to Gadgets
(3, 2), -- Headphones belong to Accessories
(3, 6), -- Headphones belongs to Office Accessories
(4, 3), -- Camera belongs to Photography
(4, 15), -- Camera belongs to Cameras
(5, 4), -- Tablet belongs to Home Electronics
(5, 16), -- Tablet belongs to Computer Displays
(6, 1), -- Smartwatch belongs to Electronics
(6, 5), -- Smartwatch belongs to Gadgets
(7, 9), -- Wireless Mouse belongs to Peripherals
(8, 7), -- 4K TV belongs to Televisions
(8, 4), -- 4K TV belongs to Home Electronics
(8, 1), -- 4K TV belongs to Electronics
(9, 8), -- Gaming Laptop belongs to Gaming
(10, 9), -- Bluetooth Speaker belongs to Audio
(10, 6), -- Bluetooth Speaker belongs to Office Accessories
(11, 10), -- External Hard Drive belongs to Storage
(11, 6), -- External Hard Drive belongs to Office Accessories
(12, 11), -- Fitness Tracker belongs to Wearables
(13, 12), -- Wireless Keyboard belongs to Peripherals
(13, 8), -- Wireless Keyboard belongs to Gaming
(14, 3), -- Drones belong to Photography
(14, 1), -- Drones belong to Electronics
(14, 15), -- Drones belong to Cameras
(14, 5), -- Drones belong to Gadgets
(15, 13), -- VR Headset belongs to Virtual Reality
(16, 14), -- Printer belongs to Printers
(16, 6), -- Printer belongs to Office Accesories
(17, 15), -- Action Camera belongs to Cameras
(18, 16), -- Computer Monitor belongs to Computer Displays
(18, 6), -- Computer Monitor belongs to Office Accesories
(19, 17); -- Power Bank belongs to Mobile Accessories