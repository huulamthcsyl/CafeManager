CREATE DATABASE QuanLiQuanCafe
GO

USE QuanLiQuanCafe
GO

CREATE TABLE TableFood
(
	id INT IDENTITY PRIMARY KEY,
	name NVARCHAR(100) DEFAULT N'Chưa đặt tên',
	status NVARCHAR(100) DEFAULT N'Trống'
)
GO

CREATE TABLE Account
(
	DisplayName NVARCHAR(100) NOT NULL DEFAULT N'Tên hiển thị',
	UserName NVARCHAR(100) PRIMARY KEY,
	PassWord NVARCHAR(1000) NOT NULL DEFAULT N'0',
	Type INT NOT NULL DEFAULT 0
)
GO

CREATE TABLE FoodCategory
(
	id INT IDENTITY PRIMARY KEY,
	name NVARCHAR(100) DEFAULT N'Chưa đặt tên'
)
GO

CREATE TABLE Food
(
	id INT IDENTITY PRIMARY KEY,
	name NVARCHAR(100) NOT NULL DEFAULT N'Chưa đặt tên',
	idCategory INT NOT NULL,
	price FLOAT NOT NULL

	FOREIGN KEY (idCategory) REFERENCES dbo.FoodCategory(id)
)
GO

CREATE TABLE Bill
(
	id INT IDENTITY PRIMARY KEY,
	DateCheckIn DATE NOT NULL DEFAULT GETDATE(),
	DateCheckOut DATE,
	idTable INT NOT NULL,
	status BIT NOT NULL DEFAULT 0

	FOREIGN KEY(idTable) REFERENCES dbo.TableFood(id)
)
GO

CREATE TABLE BillInfo
(
	id INT IDENTITY PRIMARY KEY,
	idBill INT NOT NULL,
	idFood INT NOT NULL,
	count INT NOT NULL DEFAULT 0

	FOREIGN KEY(idBill) REFERENCES dbo.Bill(id),
	FOREIGN KEY(idFood) REFERENCES dbo.Food(id)
)
GO

INSERT dbo.Account
(
    DisplayName,
    UserName,
    PassWord,
    Type
)
VALUES
(   N'Lam', -- DisplayName - nvarchar(100)
    N'Lam', -- UserName - nvarchar(100)
    N'1', -- PassWord - nvarchar(1000)
    1    -- Type - int
    )

INSERT dbo.Account
(
    DisplayName,
    UserName,
    PassWord,
    Type
)
VALUES
(   N'staff', -- DisplayName - nvarchar(100)
    N'staff', -- UserName - nvarchar(100)
    N'1', -- PassWord - nvarchar(1000)
    0    -- Type - int
    )
GO

SELECT * FROM dbo.Account
GO

CREATE PROC USP_GetAccountByUserName
@username NVARCHAR(100)
AS
BEGIN
	SELECT * FROM dbo.Account WHERE UserName = @username
END
GO

EXEC dbo.USP_GetAccountByUserName @username = N'Lam'
GO

SELECT * FROM dbo.Account WHERE UserName = N'Lam' AND PassWord = N'' OR 1=1-- ' 
GO

CREATE PROC USP_Login
@username NVARCHAR(100), @password NVARCHAR(100)
AS
BEGIN
	SELECT * FROM dbo.Account WHERE UserName = @username AND PassWord = @password
END
GO

DECLARE @i INT = 0

WHILE @i <= 10
BEGIN
	INSERT dbo.TableFood
	(
	    name
	)
	VALUES
	(   N'Bàn ' + CAST(@i AS NVARCHAR(100)) -- name - nvarchar(100)
	    )
	SET @i = @i + 1
END
GO

CREATE PROC USP_GetTableList
AS
SELECT * FROM dbo.TableFood
GO

EXEC dbo.USP_GetTableList