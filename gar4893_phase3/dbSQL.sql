-- Retrieve the current price of a stock and all portfolios with that specific stock
SELECT S.StockSymbol, S.Price, H.PortfolioID
FROM Stock S
JOIN Holds H ON S.StockSymbol = H.StockSymbol;

-- Find the total value of each portfolio based on the current stock prices
SELECT H.PortfolioID, SUM(S.Price * H.Quantity) AS TotalValue
FROM Stock S
JOIN Holds H ON S.StockSymbol = H.StockSymbol
GROUP BY H.PortfolioID;

-- Find the total value of all portfolios
SELECT SUM(S.Price * H.Quantity) AS TotalValue
FROM Stock S
JOIN Holds H ON S.StockSymbol = H.StockSymbol;

-- Find the highest, lowest stocks, stocks with the highest trading volume, and highest dividend stocks
SELECT S.StockSymbol, MAX(S.Price) AS HighestPrice, MIN(S.Price) AS LowestPrice, SUM(H.Quantity) AS TradingVolume, MAX(S.DividendYield) AS HighestDividend
FROM Stock S
JOIN Holds H ON S.StockSymbol = H.StockSymbol
GROUP BY S.StockSymbol;

-- Find the total value of dividends received by each portfolio
SELECT H.PortfolioID, SUM(S.DividendYield * H.Quantity) AS TotalDividends
FROM Stock S
JOIN Holds H ON S.StockSymbol = H.StockSymbol
GROUP BY H.PortfolioID;

-- Retrieve the total investment value of each investor
SELECT O.InvestorID, SUM(S.Price * H.Quantity) AS TotalInvestmentValue
FROM Stock S
JOIN Holds H ON S.StockSymbol = H.StockSymbol
JOIN Owns O ON H.PortfolioID = O.PortfolioID
GROUP BY O.InvestorID;

-- Retrieve the total transaction value for each portfolio, filters out portfolios with total transaction value less than 10000, and orders the results by total transaction value in descending order.
SELECT PortfolioID, SUM(TransactionValue) AS TotalTransactionValue
FROM PortfolioTransaction
GROUP BY PortfolioID
HAVING TotalTransactionValue > 10000
ORDER BY TotalTransactionValue DESC;
