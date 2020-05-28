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
GO

-- Add Food Category

INSERT dbo.FoodCategory
(
    name
)
VALUES
(N'Hải sản' -- name - nvarchar(100)
    )

INSERT dbo.FoodCategory
(
    name
)
VALUES
(N'Nông sản' -- name - nvarchar(100)
    )

INSERT dbo.FoodCategory
(
    name
)
VALUES
(N'Lâm sản' -- name - nvarchar(100)
    )

INSERT dbo.FoodCategory
(
    name
)
VALUES
(N'Nước' -- name - nvarchar(100)
    )

-- Add Food

INSERT dbo.Food
(
    name,
    idCategory,
    price
)
VALUES
(   N'Mực môt nắng', -- name - nvarchar(100)
    1,   -- idCategory - int
    120000  -- price - float
    )

INSERT dbo.Food
(
    name,
    idCategory,
    price
)
VALUES
(   N'Nghêu hấp xả', -- name - nvarchar(100)
    1,   -- idCategory - int
    50000  -- price - float
    )

INSERT dbo.Food
(
    name,
    idCategory,
    price
)
VALUES
(   N'Gà quay', -- name - nvarchar(100)
    2,   -- idCategory - int
    80000  -- price - float
    )

INSERT dbo.Food
(
    name,
    idCategory,
    price
)
VALUES
(   N'Heo rừng nướng', -- name - nvarchar(100)
    3,   -- idCategory - int
    200000  -- price - float
    )

INSERT dbo.Food
(
    name,
    idCategory,
    price
)
VALUES
(   N'7Up', -- name - nvarchar(100)
    4,   -- idCategory - int
    10000  -- price - float
    )

INSERT dbo.Food
(
    name,
    idCategory,
    price
)
VALUES
(   N'Cafe', -- name - nvarchar(100)
    4,   -- idCategory - int
    20000  -- price - float
    )

-- Add bill

INSERT dbo.Bill
(
    DateCheckIn,
    DateCheckOut,
    idTable,
    status
)
VALUES
(   GETDATE(), -- DateCheckIn - date
    NULL, -- DateCheckOut - date
    1,         -- idTable - int
    0       -- status - bit
    )

INSERT dbo.Bill
(
    DateCheckIn,
    DateCheckOut,
    idTable,
    status
)
VALUES
(   GETDATE(), -- DateCheckIn - date
    NULL, -- DateCheckOut - date
    2,         -- idTable - int
    0       -- status - bit
    )

INSERT dbo.Bill
(
    DateCheckIn,
    DateCheckOut,
    idTable,
    status
)
VALUES
(   GETDATE(), -- DateCheckIn - date
    GETDATE(), -- DateCheckOut - date
    2,         -- idTable - int
    1       -- status - bit
    )

-- Add Bill Info

INSERT dbo.BillInfo
(
    idBill,
    idFood,
    count
)
VALUES
(   1, -- idBill - int
    1, -- idFood - int
    2  -- count - int
    )

INSERT dbo.BillInfo
(
    idBill,
    idFood,
    count
)
VALUES
(   2, -- idBill - int
    3, -- idFood - int
    4  -- count - int
    )

INSERT dbo.BillInfo
(
    idBill,
    idFood,
    count
)
VALUES
(   1, -- idBill - int
    5, -- idFood - int
    1  -- count - int
    )

INSERT dbo.BillInfo
(
    idBill,
    idFood,
    count
)
VALUES
(   2, -- idBill - int
    3, -- idFood - int
    5  -- count - int
    )
GO

SELECT * FROM dbo.Bill
SELECT * FROM dbo.BillInfo
SELECT * FROM dbo.Food
SELECT * FROM dbo.FoodCategory

SELECT * FROM dbo.Bill WHERE idTable = 1 AND status = 0

SELECT * FROM dbo.BillInfo WHERE idBill = 1

SELECT * FROM dbo.TableFood

SELECT f.name, bi.count, f.price, f.price * bi.count AS totalPrice FROM dbo.BillInfo AS bi, dbo.Bill AS b, dbo.Food AS f
WHERE bi.idBill = b.id AND bi.idFood = f.id AND b.idTable = 1
