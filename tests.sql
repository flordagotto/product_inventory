SELECT name AS 'SP name' FROM sys.procedures 
-- It should return a table with all the SPs: create_category, create_product, delete_category, delete_product, 
-- read_category, read_product, read_product_by_category_id, read_product_by_name, update_category, update_product

SELECT * from product -- Compare results with exec read_product
EXEC read_product -- It should return the same table than the previous select

SELECT * from product WHERE id = 10 -- Compare results with exec read_product (37)
EXEC read_product @id = 10 -- It should return the same table than the previous select

SELECT * from product WHERE product_name = 'Tablet' -- Compare results with exec read_product (37)
EXEC read_product_by_name @name = 'Tablet' -- It should return the same table than the previous select

SELECT p.id, p.product_name, p.product_description, p.price from product p
JOIN products_per_category pxc ON pxc.product_id = p.id
JOIN category c ON c.id = pxc.category_id 
WHERE c.id = 1 -- Compare results with exec read_product (1)
EXEC read_product_by_category_id @category_id = 1 -- It should return the same table than the previous select

SELECT * from product 
SELECT * from products_per_category 
EXEC create_product @name = 'Cooler', @category_ids = '1,2', @price = 15.59, @description = 'Cooler'
SELECT * from product -- It should return one more product
SELECT * from products_per_category -- It should return two more rows, one for each category added to the new product
-- It should log a message 'Product added with id 20'

SELECT * from product 
SELECT * from products_per_category 
EXEC create_product @name = 'New product', @category_ids = '1500', @price = 23.56, @description = NULL 
-- It should log an error message 'Category Id 1500 does not exist in table category'
SELECT * from product 
SELECT * from products_per_category 
-- Both results should remain the same

SELECT * from product 
SELECT * from products_per_category 
EXEC create_product @name = 'New product', @category_ids = NULL, @price = -5.26, @description = NULL 
-- It should log an error message 'Price must be bigger than 0 for product name New Product' 
SELECT * from product 
SELECT * from products_per_category 
-- Both results should remain the same

SELECT * from product where id = 20
SELECT * from products_per_category where product_id = 20
EXEC update_product @id = 20, @new_category_ids = '3', @description = 'Cooler RGB'
SELECT * from product where id = 20 -- It should return the product with the new description 'Cooler RGB'
SELECT * from products_per_category where product_id = 20 -- It should return one more row, for the category 3 added to the product 20
-- It should log a message 'Product updated with id 20'

SELECT * from product WHERE id = 20
SELECT * from products_per_category 
EXEC update_product @id = 20, @name = NULL, @new_category_ids = '2', @price = NULL, @description = NULL 
-- It should log an error message 'Category Id 2 already registered for Product Id 20'

SELECT * from product WHERE id = 20
SELECT * from products_per_category 
EXEC update_product @id = 20, @name = NULL, @new_category_ids = '1500', @price = NULL, @description = NULL 
-- It should log an error message 'Category Id 1500 does not exist in table category'
SELECT * from product WHERE id = 20
SELECT * from products_per_category WHERE product_id = 20
-- Both results should remain the same

SELECT * from product WHERE id = 20
SELECT * from products_per_category WHERE product_id = 20
EXEC update_product @id = 20, @name = NULL, @new_category_ids = NULL, @price = 0, @description = NULL 
-- It should log an error message 'Price must be bigger than 0 for product id 20' 
SELECT * from product WHERE id = 20
SELECT * from products_per_category WHERE product_id = 20
-- Both results should remain the same

EXEC delete_product @id = 20
SELECT * from product where id = 20 -- It should return an empty table
SELECT * from products_per_category where product_id = 20 -- It should return an empty table
-- It should log a message 'Product deleted with id 20'

SELECT * from category -- Compare results with exec read_category
EXEC read_category -- It should return the same table than the previous select

SELECT * from category WHERE id = 4 -- Compare results with exec read_category (16)
EXEC read_category @id = 4 -- It should return the same table than the previous select

SELECT * from category
EXEC create_category @name = 'Miscellaneous', @description = 'Variety'
SELECT * from category -- It should return one more row with the new category
-- It should log a message 'Category added with id 18'

SELECT * from category WHERE id = 18
EXEC update_category @id = 18, @name = NULL, @description = 'Variety of products'
SELECT * from category WHERE id = 18 -- It should return the category with the new description 'Variety of products'
-- It should log a message 'Category updated with id 18'

EXEC delete_category @id = 18
SELECT * from category where id = 18 -- It should return an empty table
SELECT * from products_per_category where category_id = 18 -- It should return an empty table
-- It should log a message 'Category deleted with id 18'