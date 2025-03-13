-- Drop triggers
DROP TRIGGER IF EXISTS update_holds_table;
DROP TRIGGER IF EXISTS update_own_table;
DROP TRIGGER IF EXISTS update_company_news_mentions;

-- Drop views
DROP VIEW IF EXISTS InvestorPortfolioSummary;

-- Drop procedures
DROP PROCEDURE IF EXISTS CalculatePortfolioValue;

-- Drop tables
DROP TABLE IF EXISTS Holds;
DROP TABLE IF EXISTS Owns;
DROP TABLE IF EXISTS PortfolioTransaction;
DROP TABLE IF EXISTS Stock;
DROP TABLE IF EXISTS Portfolio;
DROP TABLE IF EXISTS Company;
DROP TABLE IF EXISTS Sector;
DROP TABLE IF EXISTS Investor;
