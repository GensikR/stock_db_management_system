-- Inserting into Investor table
INSERT INTO Investor (InvestorID, FirstName, MiddleName, LastName, UserName, DateOfBirth, Password, StreetNumber, City, State, Country, Zip, CurrentBalance)
VALUES
    (1, 'John', '', 'Doe', 'johndoe', '1990-05-15', 'password1', '123 Main St', 'Anytown', 'CA', 'USA', '12345', 50000.00),
    (2, 'Alice', 'M', 'Smith', 'asmith', '1985-09-22', 'mypassword', '456 Elm St', 'Smalltown', 'NY', 'USA', '54321', 75000.00),
    (3, 'Bob', '', 'Johnson', 'bjohnson', '1978-11-10', 'secure123', '789 Oak St', 'Bigcity', 'TX', 'USA', '67890', 100000.00),
    (4, 'Sarah', 'A', 'Brown', 'sbrown', '1995-03-30', 'password123', '101 Pine St', 'Somewhere', 'FL', 'USA', '13579', 25000.00),
    (5, 'Michael', '', 'Wilson', 'mwilson', '1980-07-18', 'mypass', '202 Cedar St', 'Nowhere', 'AZ', 'USA', '24680', 300000.00);

-- Inserting into Portfolio table
INSERT INTO Portfolio (PortfolioID, PortfolioDate, PortfolioValue)
VALUES
    (1, '2023-01-01', 50000.00),
    (2, '2024-05-01', 75000.00),
    (3, '2020-04-06', 100000.00),
    (4, '2024-06-01', 25000.00),
    (5, '2020-02-22', 300000.00);

-- Inserting into Owns table
INSERT INTO Owns (InvestorID, PortfolioID, OwnershipPercentage)
VALUES
    (1, 1, 100.00),
    (2, 2, 100.00),
    (3, 3, 100.00),
    (4, 4, 100.00),
    (5, 5, 100.00);


-- Inserting into Stock table
INSERT INTO Stock (StockSymbol, BetaValue, CompanyName, Price, MarketCap, DividendYield, Volatility)
VALUES
    ('ABC', 1.5, 'ABC Corp', 100.00, 5000000.00, 2.5, 'Medium'),
    ('XYZ', 1.2, 'XYZ Inc', 75.00, 3000000.00, 1.8, 'Low'),
    ('DEF', 0.8, 'DEF Ltd', 50.00, 2000000.00, 1.0, 'Low'),
    ('GHI', 1.0, 'GHI Co', 80.00, 1500000.00, 0.5, 'Low'),
    ('JKL', 1.3, 'JKL Corp', 95.00, 1800000.00, 1.2, 'Medium'),
    ('MNO', 1.6, 'MNO Inc', 110.00, 2200000.00, 1.5, 'Medium'),
    ('PQR', 0.9, 'PQR Ltd', 60.00, 2500000.00, 1.2, 'Low'),
    ('STU', 1.4, 'STU Co', 85.00, 1700000.00, 0.8, 'Low'),
    ('VWX', 1.1, 'VWX Corp', 70.00, 1900000.00, 1.0, 'Low'),
    ('YZA', 1.7, 'YZA Inc', 120.00, 2300000.00, 1.8, 'Medium'),
    ('BCD', 1.2, 'BCD Ltd', 75.00, 2800000.00, 1.2, 'Medium'),
    ('EFG', 1.0, 'EFG Co', 80.00, 1300000.00, 0.5, 'Low'),
    ('HIJ', 1.3, 'HIJ Corp', 95.00, 1600000.00, 1.2, 'Low'),
    ('KLM', 1.6, 'KLM Inc', 110.00, 2100000.00, 1.5, 'Medium'),
    ('NOP', 0.9, 'NOP Ltd', 60.00, 2400000.00, 1.2, 'Low'),
    ('QRS', 1.4, 'QRS Co', 85.00, 1600000.00, 0.8, 'Low'),
    ('TUV', 1.1, 'TUV Corp', 70.00, 2000000.00, 1.0, 'Low'),
    ('WXY', 1.7, 'WXY Inc', 120.00, 2400000.00, 1.8, 'Medium'),
    ('ZAB', 1.2, 'ZAB Ltd', 75.00, 2900000.00, 1.2, 'Medium'),
    ('CDE', 1.0, 'CDE Co', 80.00, 1400000.00, 0.5, 'Low');

-- Inserting into Sector table
INSERT INTO Sector (SectorID, SectorName)
VALUES
    (1, 'Technology'),
    (2, 'Finance'),
    (3, 'Healthcare'),
    (4, 'Energy'),
    (5, 'Consumer Goods');

-- Inserting into Company table
INSERT INTO Company (CompanyID, CompanyName, StockSymbol, C_Size, C_StreetNumber, C_City, C_State, C_Country, C_Zip, NumberOfNewsMentions, SectorID)
VALUES
    (1, 'ABC Corp', 'ABC', 'large', '123 Main St', 'Anytown', 'NY', 'USA', '12345', 0, 1),
    (2, 'XYZ Inc', 'XYZ', 'medium', '456 Elm St', 'Othertown', 'CA', 'USA', '67890', 0, 2),
    (3, 'DEF Ltd', 'DEF', 'small', '789 Oak St', 'Another town', 'TX', 'USA', '13579', 0, 3),
    (4, 'GHI Co', 'GHI', 'large', '321 Pine St', 'Sometown', 'FL', 'USA', '24680', 0, 4),
    (5, 'JKL Corp', 'JKL', 'medium', '654 Maple St', 'Newtown', 'WA', 'USA', '97531', 0, 5),
    (6, 'MNO Inc', 'MNO', 'small', '987 Birch St', 'Yourtown', 'IL', 'USA', '86420', 0, 1),
    (7, 'PQR Ltd', 'PQR', 'large', '741 Cedar St', 'Histown', 'AZ', 'USA', '12345', 0, 2),
    (8, 'STU Co', 'STU', 'medium', '852 Walnut St', 'Hertown', 'GA', 'USA', '67890', 0, 3),
    (9, 'VWX Corp', 'VWX', 'small', '963 Cherry St', 'Hometown', 'MI', 'USA', '13579', 0, 4),
    (10, 'YZA Inc', 'YZA', 'large', '147 Rose St', 'Hertown', 'GA', 'USA', '97531', 0, 5),
    (11, 'BCD Ltd', 'BCD', 'medium', '258 Vine St', 'Histown', 'AZ', 'USA', '86420', 0, 1),
    (12, 'EFG Co', 'EFG', 'small', '369 Pineapple St', 'Newtown', 'CA', 'USA', '24680', 0, 2),
    (13, 'HIJ Corp', 'HIJ', 'large', '753 Apple St', 'Sometown', 'TX', 'USA', '86420', 0, 3),
    (14, 'KLM Inc', 'KLM', 'medium', '159 Orange St', 'Othertown', 'FL', 'USA', '97531', 0, 4),
    (15, 'NOP Ltd', 'NOP', 'small', '852 Lemon St', 'Yourtown', 'WA', 'USA', '67890', 0, 5),
    (16, 'QRS Co', 'QRS', 'large', '963 Banana St', 'Histown', 'GA', 'USA', '12345', 0, 1),
    (17, 'TUV Corp', 'TUV', 'medium', '741 Grape St', 'Hertown', 'MI', 'USA', '97531', 0, 2),
    (18, 'WXY Inc', 'WXY', 'small', '456 Cherry St', 'Hometown', 'IL', 'USA', '24680', 0, 3),
    (19, 'ZAB Ltd', 'ZAB', 'large', '147 Plum St', 'Newtown', 'CA', 'USA', '67890', 0, 4),
    (20, 'CDE Co', 'CDE', 'medium', '369 Peach St', 'Sometown', 'TX', 'USA', '13579', 0, 5);

INSERT INTO Holds (PortfolioID, StockSymbol, Quantity)
VALUES
    (1, 'ABC', 50),
    (1, 'DEF', 100),
    (2, 'XYZ', 25),
    (2, 'JKL', 30),
    (3, 'ABC', 60),
    (4, 'XYZ', 30),
    (4, 'MNO', 20),
    (4, 'STU', 40),
    (5, 'ABC', 150),
    (5, 'JKL', 75);


-- Inserting into PortfolioTransaction table
INSERT INTO PortfolioTransaction (TransactionID, TransactionType, NumberOfSharesTraded, StockSymbol, PortfolioID, TransactionValue, TransactionDate)
VALUES
    (1, 'buy', 100, 'ABC', 1, (SELECT Price * 100 FROM Stock WHERE StockSymbol = 'ABC'), '2024-01-16'),
    (2, 'buy', 50, 'XYZ', 2, (SELECT Price * 50 FROM Stock WHERE StockSymbol = 'XYZ'), '2024-01-26'),
    (3, 'sell', 75, 'DEF', 3, (SELECT Price * 75 FROM Stock WHERE StockSymbol = 'DEF'), '2024-02-13'),
    (4, 'buy', 80, 'GHI', 1, (SELECT Price * 80 FROM Stock WHERE StockSymbol = 'GHI'), '2024-02-12'),
    (5, 'sell', 60, 'JKL', 2, (SELECT Price * 60 FROM Stock WHERE StockSymbol = 'JKL'), '2024-03-23');
