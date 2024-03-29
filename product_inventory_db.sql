USE [master]
GO
/****** Object:  Database [ProductInventory]    Script Date: 05/03/2024 11:50:33 ******/
CREATE DATABASE [ProductInventory]
WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [ProductInventory] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ProductInventory].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ProductInventory] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ProductInventory] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ProductInventory] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ProductInventory] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ProductInventory] SET ARITHABORT OFF 
GO
ALTER DATABASE [ProductInventory] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ProductInventory] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ProductInventory] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ProductInventory] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ProductInventory] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ProductInventory] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ProductInventory] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ProductInventory] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ProductInventory] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ProductInventory] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ProductInventory] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ProductInventory] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ProductInventory] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ProductInventory] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ProductInventory] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ProductInventory] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ProductInventory] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ProductInventory] SET RECOVERY FULL 
GO
ALTER DATABASE [ProductInventory] SET  MULTI_USER 
GO
ALTER DATABASE [ProductInventory] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ProductInventory] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ProductInventory] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ProductInventory] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [ProductInventory] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'ProductInventory', N'ON'
GO
ALTER DATABASE [ProductInventory] SET QUERY_STORE = OFF
GO
USE [ProductInventory]
GO
/****** Object:  Table [dbo].[category]    Script Date: 05/03/2024 11:50:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[category](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[category_name] [varchar](20) NOT NULL,
	[category_description] [varchar](50) NULL,
 CONSTRAINT [PK_category] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[logs]    Script Date: 05/03/2024 11:50:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[logs](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[log_message] [nvarchar](max) NOT NULL,
	[log_date] [datetime] NOT NULL,
	[procedure_name] [varchar](50) NOT NULL,
	[error_line] [int] NULL,
 CONSTRAINT [PK_errors] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[product]    Script Date: 05/03/2024 11:50:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[product](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[product_name] [varchar](20) NOT NULL,
	[product_description] [varchar](50) NULL,
	[price] [decimal](10, 2) NOT NULL,
 CONSTRAINT [PK_product] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[products_per_category]    Script Date: 05/03/2024 11:50:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[products_per_category](
	[product_id] [int] NOT NULL,
	[category_id] [int] NOT NULL,
 CONSTRAINT [PK_products_per_category] PRIMARY KEY CLUSTERED 
(
	[product_id] ASC,
	[category_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[products_per_category]  WITH CHECK ADD  CONSTRAINT [FK_category_products_per_category] FOREIGN KEY([category_id])
REFERENCES [dbo].[category] ([id])
GO
ALTER TABLE [dbo].[products_per_category] CHECK CONSTRAINT [FK_category_products_per_category]
GO
ALTER TABLE [dbo].[products_per_category]  WITH CHECK ADD  CONSTRAINT [FK_products_per_category_products] FOREIGN KEY([product_id])
REFERENCES [dbo].[product] ([id])
GO
ALTER TABLE [dbo].[products_per_category] CHECK CONSTRAINT [FK_products_per_category_products]
GO
/****** Object:  StoredProcedure [dbo].[create_category]    Script Date: 05/03/2024 11:50:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[create_category] @name varchar(20), @description varchar(50) = NULL
AS
BEGIN
	DECLARE @category_id INT
	BEGIN TRY
		INSERT INTO category(category_name, category_description) 
		VALUES(@name, @description)
		SET @category_id = SCOPE_IDENTITY()

		INSERT INTO logs(log_message, log_date, procedure_name)
		VALUES ('Category added with id ' + CAST(@category_id as nvarchar(15)), GETDATE(), 'create_category')
	END TRY
	BEGIN CATCH
		INSERT INTO logs(log_message, log_date, procedure_name, error_line)
		VALUES (ERROR_MESSAGE(), GETDATE(), ERROR_PROCEDURE(), ERROR_LINE())
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[create_product]    Script Date: 05/03/2024 11:50:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[create_product] @name varchar(20), @category_ids nvarchar(max), @price decimal(10,2), @description varchar(50) = NULL
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @product_id INT, @current_category INT, @error_message NVARCHAR(150)
	BEGIN TRANSACTION
		BEGIN TRY
			IF (@price <= 0)
			BEGIN
				SET @error_message = N'Price must be bigger than 0 for product name ' + @name;
				THROW 50000, @error_message, 1
			END

			INSERT INTO product(product_name, product_description, price) 
			VALUES(@name, @description, @price)
			SET @product_id = SCOPE_IDENTITY()

			DECLARE @category_ids_table TABLE (category_id int)
			INSERT INTO @category_ids_table(category_id) SELECT value FROM string_split(@category_ids, ',')
			
			DECLARE @categories_cursor CURSOR;
			SET @categories_cursor = CURSOR FOR SELECT category_id FROM @category_ids_table;
			OPEN @categories_cursor
			FETCH NEXT FROM @categories_cursor INTO @current_category
			
			WHILE @@FETCH_STATUS = 0
			BEGIN
				IF EXISTS (SELECT 1 FROM category WHERE id = @current_category)
				BEGIN
					INSERT INTO products_per_category(product_id, category_id)
					VALUES(@product_id, @current_category)
					FETCH NEXT FROM @categories_cursor INTO @current_category
				END
				ELSE
				BEGIN
					SET @error_message = N'Category Id ' + CAST(@current_category AS NVARCHAR(15)) + N' does not exist in table category';
					THROW 50000, @error_message, 1
				END
			END
			CLOSE @categories_cursor;
			DEALLOCATE @categories_cursor;

			INSERT INTO logs(log_message, log_date, procedure_name)
			VALUES ('Product added with id ' + CAST(@product_id as nvarchar(15)), GETDATE(), 'create_product')

			COMMIT TRANSACTION
		END TRY
		BEGIN CATCH
			ROLLBACK TRANSACTION
			INSERT INTO logs(log_message, log_date, procedure_name, error_line)
			VALUES (ERROR_MESSAGE(), GETDATE(), ERROR_PROCEDURE(), ERROR_LINE())
		END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[delete_category]    Script Date: 05/03/2024 11:50:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[delete_category] (@id int)
AS
BEGIN
	BEGIN TRANSACTION
		BEGIN TRY
			DELETE FROM products_per_category WHERE category_id = @id
			DELETE FROM category WHERE id = @id
			INSERT INTO logs(log_message, log_date, procedure_name)
			VALUES ('Category deleted with id ' + CAST(@id as nvarchar(15)), GETDATE(), 'delete_category')
			COMMIT TRANSACTION
		END TRY
		BEGIN CATCH
			ROLLBACK TRANSACTION
			INSERT INTO logs(log_message, log_date, procedure_name, error_line)
			VALUES (ERROR_MESSAGE(), GETDATE(), ERROR_PROCEDURE(), ERROR_LINE())
		END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[delete_product]    Script Date: 05/03/2024 11:50:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[delete_product] (@id int)
AS
BEGIN
	BEGIN TRANSACTION
		BEGIN TRY
			DELETE FROM products_per_category WHERE product_id = @id
			DELETE FROM product WHERE id = @id
			INSERT INTO logs(log_message, log_date, procedure_name)
			VALUES ('Product deleted with id ' + CAST(@id as nvarchar(15)), GETDATE(), 'delete_product')
			COMMIT TRANSACTION
		END TRY
		BEGIN CATCH
			ROLLBACK TRANSACTION
			INSERT INTO logs(log_message, log_date, procedure_name, error_line)
			VALUES (ERROR_MESSAGE(), GETDATE(), ERROR_PROCEDURE(), ERROR_LINE())
		END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[read_category]    Script Date: 05/03/2024 11:50:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[read_category] (@id int = NULL)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @query NVARCHAR(max)
	SET @query = N'SELECT id, category_name, category_description FROM category'
	IF (@id IS NOT NULL AND @id > 0)
	BEGIN
		SET @query = @query + N' WHERE id = @id'
	END
	EXEC sp_executesql @query, N'@id int', @id = @id
END
GO
/****** Object:  StoredProcedure [dbo].[read_product]    Script Date: 05/03/2024 11:50:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[read_product] (@id int = NULL)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @query NVARCHAR(max)
	SET @query = N'SELECT id, product_name, product_description, price FROM product'
	IF (@id IS NOT NULL AND @id > 0)
	BEGIN
		SET @query = @query + N' WHERE id = @id'
	END
	EXEC sp_executesql @query, N'@id int', @id = @id
END
GO
/****** Object:  StoredProcedure [dbo].[read_product_by_category_id]    Script Date: 05/03/2024 11:50:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[read_product_by_category_id] (@category_id int)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT p.id, p.product_name, p.product_description, p.price 
	FROM product p 
	JOIN products_per_category pxc ON p.id = pxc.product_id
	JOIN category c ON pxc.category_id = c.id
	WHERE c.id = @category_id
END
GO
/****** Object:  StoredProcedure [dbo].[read_product_by_name]    Script Date: 05/03/2024 11:50:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[read_product_by_name] (@name varchar(50))
AS
BEGIN
	SET NOCOUNT ON;
	SELECT id, product_name, product_description, price FROM product WHERE product_name = @name
END
GO
/****** Object:  StoredProcedure [dbo].[update_category]    Script Date: 05/03/2024 11:50:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[update_category] (@id int, @name varchar(20) = NULL, @description varchar(50) = NULL)
AS
	BEGIN
	BEGIN TRY
		IF (@name IS NOT NULL OR @description IS NOT NULL)
		BEGIN
			DECLARE @query NVARCHAR(max)
			SET @query = N'UPDATE category SET '
			IF (@name IS NOT NULL)
			BEGIN
				SET @query = @query + N' category_name = @name,'
			END
			IF (@description IS NOT NULL)
			BEGIN
				SET @query = @query + N' category_description = @description,'
			END
			SET @query = LEFT(@query, LEN(@query) - 1) + N' WHERE id = @id'
			EXEC sp_executesql @query, N'@name NVARCHAR(MAX), @description NVARCHAR(MAX), @id INT', @name = @name, @description = @description, @id = @id

			INSERT INTO logs(log_message, log_date, procedure_name)
			VALUES ('Category updated with id ' + CAST(@id as nvarchar(15)), GETDATE(), 'update_category')
		END
	END TRY
	BEGIN CATCH
		INSERT INTO logs(log_message, log_date, procedure_name, error_line)
		VALUES (ERROR_MESSAGE(), GETDATE(), ERROR_PROCEDURE(), ERROR_LINE())
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[update_product]    Script Date: 05/03/2024 11:50:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[update_product] @id int, @name varchar(20) = NULL, @new_category_ids nvarchar(max) = NULL, @price decimal(10,2) = NULL, @description varchar(50) = NULL
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @current_category INT, @error_message NVARCHAR(150)
	BEGIN TRANSACTION
	BEGIN TRY
		IF (@id IS NOT NULL AND @id > 0)
		BEGIN
			IF (@new_category_ids IS NOT NULL)
			BEGIN
				DECLARE @category_ids_table TABLE (category_id int)
				INSERT INTO @category_ids_table(category_id) SELECT value FROM string_split(@new_category_ids, ',')
			
				DECLARE @categories_cursor CURSOR;
				SET @categories_cursor = CURSOR FOR SELECT category_id FROM @category_ids_table;
				OPEN @categories_cursor
				FETCH NEXT FROM @categories_cursor INTO @current_category
				-- TODO: feature deleting products_per_category row if sent category_ids doesnt contain categories that are already related to product
				WHILE @@FETCH_STATUS = 0
				BEGIN
					IF (EXISTS (SELECT 1 FROM category WHERE id = @current_category))
					BEGIN
						IF (NOT EXISTS (SELECT 1 FROM products_per_category WHERE product_id = @id AND category_id = @current_category))
						BEGIN
							INSERT INTO products_per_category(product_id, category_id)
							VALUES(@id, @current_category)
						END 
						ELSE
						BEGIN
							SET @error_message = N'Category Id ' + CAST(@current_category AS NVARCHAR(15)) + N' already registered for Product Id ' + CAST(@id AS NVARCHAR(15)) ;
							THROW 50000, @error_message, 1
						END
						FETCH NEXT FROM @categories_cursor INTO @current_category
					END
					ELSE
					BEGIN
						SET @error_message = N'Category Id ' + CAST(@current_category AS NVARCHAR(15)) + N' does not exist in table category';
						THROW 50000, @error_message, 1
					END
				END
				CLOSE @categories_cursor;
				DEALLOCATE @categories_cursor;
			END
			IF (@name IS NOT NULL OR @price IS NOT NULL OR @description IS NOT NULL)
			BEGIN
				DECLARE @query NVARCHAR(max)
				SET @query = N'UPDATE product SET '
				IF (@name IS NOT NULL)
				BEGIN
					SET @query = @query + N' product_name = @name,'
				END
				IF (@description IS NOT NULL)
				BEGIN
					SET @query = @query + N' product_description = @description,'
				END
				IF (@price IS NOT NULL)
				BEGIN
					IF (@price <= 0)
					BEGIN
					SET @error_message = N'Price must be bigger than 0 for Product Id ' + CAST(@id as nvarchar(15));
						THROW 50000, @error_message, 1
					END
					SET @query = @query + N' price = @price,'
				END
				SET @query = LEFT(@query, LEN(@query) - 1) + N' WHERE id = @id'
				EXEC sp_executesql @query, N'@name NVARCHAR(MAX), @description NVARCHAR(MAX), @price DECIMAL(10,2), @id INT', @name = @name, @description = @description, @price = @price, @id = @id

				INSERT INTO logs(log_message, log_date, procedure_name)
				VALUES ('Product updated with id ' + CAST(@id as nvarchar(15)), GETDATE(), 'update_product')
			END
			COMMIT TRANSACTION
		END
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
		INSERT INTO logs(log_message, log_date, procedure_name, error_line)
		VALUES (ERROR_MESSAGE(), GETDATE(), ERROR_PROCEDURE(), ERROR_LINE())
	END CATCH
END
GO
USE [master]
GO
ALTER DATABASE [ProductInventory] SET  READ_WRITE 
GO
