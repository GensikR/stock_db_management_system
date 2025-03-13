-- Table representing investors
CREATE TABLE Investor (
    InvestorID INT PRIMARY KEY,
    FirstName VARCHAR(255) NOT NULL,
    MiddleName VARCHAR(255) DEFAULT NULL,
    LastName VARCHAR(255) NOT NULL,
    UserName VARCHAR(255) UNIQUE NOT NULL,
    DateOfBirth DATE NOT NULL,
    Password VARCHAR(255) NOT NULL,
    StreetNumber VARCHAR(255) NOT NULL,
    City VARCHAR(255) NOT NULL,
    State VARCHAR(255) NOT NULL,
    Country VARCHAR(255) NOT NULL,
    Zip VARCHAR(255) NOT NULL,
    CurrentBalance DECIMAL(18, 2) NOT NULL
);

-- Table representing sectors
CREATE TABLE Sector (
    SectorID INT PRIMARY KEY,
    SectorName VARCHAR(255) NOT NULL,
    NumberOfNewsMentions INT DEFAULT 0
);

-- Table representing companies
CREATE TABLE Company (
    CompanyID INT PRIMARY KEY,
    CompanyName VARCHAR(255) NOT NULL,
    StockSymbol VARCHAR(20) UNIQUE NOT NULL,
    C_Size ENUM('small', 'medium', 'large') NOT NULL,
    C_StreetNumber VARCHAR(255) NOT NULL,
    C_City VARCHAR(255) NOT NULL,
    C_State VARCHAR(255) NOT NULL,
    C_Country VARCHAR(255) NOT NULL,
    C_Zip VARCHAR(255) NOT NULL,
    NumberOfNewsMentions INT DEFAULT 0,
    SectorID INT,
    FOREIGN KEY (SectorID) REFERENCES Sector(SectorID)
);

-- Table representing portfolios
CREATE TABLE Portfolio (
    PortfolioID INT PRIMARY KEY,
    PortfolioDate DATE NOT NULL,
    PortfolioValue DECIMAL(18, 2) NOT NULL
);

-- Table representing stocks
CREATE TABLE Stock (
    StockSymbol VARCHAR(20) PRIMARY KEY,
    BetaValue FLOAT NOT NULL,
    CompanyName VARCHAR(255) NOT NULL,
    Price DECIMAL(18, 2) NOT NULL,
    MarketCap DECIMAL(18, 2) NOT NULL,
    DividendYield DECIMAL(18, 2) NOT NULL,
    Volatility ENUM('low', 'medium', 'high') NOT NULL
);

-- Table representing transactions
CREATE TABLE PortfolioTransaction (
    TransactionID INT PRIMARY KEY,
    TransactionType ENUM('sell', 'buy') NOT NULL,
    NumberOfSharesTraded INT NOT NULL,
    StockSymbol VARCHAR(20) NOT NULL,
    PortfolioID INT NOT NULL,
    TransactionValue DECIMAL(18, 2) NOT NULL,
    TransactionDate DATE NOT NULL,
    FOREIGN KEY (StockSymbol) REFERENCES Stock(StockSymbol),
    FOREIGN KEY (PortfolioID) REFERENCES Portfolio(PortfolioID)
);

-- Table representing the ownership relationship between investors and portfolios
CREATE TABLE Owns (
    InvestorID INT NOT NULL,
    PortfolioID INT NOT NULL,
    OwnershipPercentage DECIMAL(5, 2) NOT NULL,
    PRIMARY KEY (InvestorID, PortfolioID),
    FOREIGN KEY (InvestorID) REFERENCES Investor(InvestorID),
    FOREIGN KEY (PortfolioID) REFERENCES Portfolio(PortfolioID)
);

-- Table representing the holdings relationship between portfolios and stocks
CREATE TABLE Holds (
    PortfolioID INT NOT NULL,
    StockSymbol VARCHAR(20) NOT NULL,
    Quantity INT NOT NULL,
    PRIMARY KEY (PortfolioID, StockSymbol),
    FOREIGN KEY (PortfolioID) REFERENCES Portfolio(PortfolioID),
    FOREIGN KEY (StockSymbol) REFERENCES Stock(StockSymbol)
);

-- Update Holds Table after every Insertion in Transaction table
DELIMITER //
CREATE TRIGGER UpdateHolds
AFTER INSERT ON PortfolioTransaction
FOR EACH ROW
BEGIN
    DECLARE current_quantity INT;
    DECLARE new_quantity INT;
    
    -- Get the current quantity of the stock in the Holds table
    SELECT Quantity INTO current_quantity
    FROM Holds
    WHERE PortfolioID = NEW.PortfolioID AND StockSymbol = NEW.StockSymbol;
    
    -- Calculate the new quantity based on the transaction type
    IF NEW.TransactionType = 'buy' THEN
        SET new_quantity = current_quantity + NEW.NumberOfSharesTraded;
    ELSE
        SET new_quantity = current_quantity - NEW.NumberOfSharesTraded;
    END IF;
    
    -- Update the Holds table with the new quantity
    UPDATE Holds
    SET Quantity = new_quantity
    WHERE PortfolioID = NEW.PortfolioID AND StockSymbol = NEW.StockSymbol;
END//
DELIMITER ;
