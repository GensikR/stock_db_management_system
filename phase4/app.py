from flask import Flask, render_template, jsonify, request
from flaskext.mysql import MySQL

app = Flask(__name__)

mysql = MySQL()
app.config['MYSQL_DATABASE_USER'] = 'root'
app.config['MYSQL_DATABASE_PASSWORD'] = 'NuevoTocumen06!'
app.config['MYSQL_DATABASE_DB'] = 'cse3330db'
app.config['MYSQL_DATABASE_HOST'] = 'localhost'
mysql.init_app(app)

conn = mysql.connect()
cursor = conn.cursor()

@app.route('/')
def home():
    return render_template('index.html')

@app.route('/stock_info')
def stock_info():
    # Add logic to retrieve stock information
    return render_template('stock_info.html')

@app.route('/portfolio_info')
def portfolio_info():
    # Add logic to retrieve portfolio information
    return render_template('portfolio_info.html')

@app.route('/investor_info')
def investor_information():
    return render_template('investor_info.html')


"""
     4 Investors Info Queries
"""
@app.route('/total_investment_val', methods=['GET'])
def total_investment_val():
  query = """
      SELECT 
          O.InvestorID, 
          CONCAT(I.FirstName, ' ', I.LastName) AS InvestorName,
          SUM(S.Price * H.Quantity) AS TotalInvestmentValue
      FROM 
          Stock S
          JOIN Holds H ON S.StockSymbol = H.StockSymbol
          JOIN Owns O ON H.PortfolioID = O.PortfolioID
          JOIN Investor I ON O.InvestorID = I.InvestorID
      GROUP BY 
          O.InvestorID, I.FirstName, I.LastName;
  """
  cursor.execute(query)

  result = format_result(cursor.fetchall())
  
  return result

@app.route('/investors_total_div', methods=['GET'])
def investors_total_div():
  query = """
      SELECT H.PortfolioID, SUM(S.DividendYield * H.Quantity) AS TotalDividends
      FROM Stock S
      JOIN Holds H ON S.StockSymbol = H.StockSymbol
      GROUP BY H.PortfolioID;
  """
  cursor.execute(query)

  result = format_result(cursor.fetchall())
  
  return result

@app.route('/investors_with_greater_investment', methods=['GET'])
def investors_with_greater_investment():
    threshold = request.args.get('threshold', type=float)
    query = """
        SELECT
            CONCAT(I.FirstName, ' ', I.LastName) AS InvestorName
        FROM
            Owns O
            JOIN Investor I ON O.InvestorID = I.InvestorID
            JOIN Portfolio P ON O.PortfolioID = P.PortfolioID
            JOIN PortfolioTransaction PT ON P.PortfolioID = PT.PortfolioID
            JOIN Stock S ON PT.StockSymbol = S.StockSymbol
        GROUP BY
            O.InvestorID, I.FirstName, I.LastName
        HAVING
            SUM(PT.NumberOfSharesTraded * S.Price) > %s;
    """
    cursor.execute(query, (threshold,))

    result = format_result(cursor.fetchall())

    return result

@app.route('/investors_more_divs', methods=['GET'])
def investors_more_divs():
    threshold = request.args.get('threshold', type=float)
    query = """
        SELECT
            CONCAT(I.FirstName, ' ', I.LastName) AS InvestorName
        FROM
            Owns O
            JOIN Investor I ON O.InvestorID = I.InvestorID
            JOIN Portfolio P ON O.PortfolioID = P.PortfolioID
            JOIN PortfolioTransaction PT ON P.PortfolioID = PT.PortfolioID
            JOIN Stock S ON PT.StockSymbol = S.StockSymbol
        WHERE
            PT.TransactionType = 'buy'
            AND PT.TransactionDate >= DATE_SUB(NOW(), INTERVAL 1 YEAR) -- Adjust as needed
        GROUP BY
            O.InvestorID, I.FirstName, I.LastName
        HAVING
            SUM(S.DividendYield * PT.NumberOfSharesTraded * S.Price) > %s;
    """
    cursor.execute(query, (threshold,))

    result = format_result(cursor.fetchall())

    return result

"""
    4 Portfolio Info Queries
"""




@app.route('/total_div_portfolio', methods=['GET'])
def total_div_portfolio():
    query = """
        SELECT PT.PortfolioID, SUM(ST.DividendYield * PT.NumberOfSharesTraded * ST.Price) AS TotalDividends
        FROM PortfolioTransaction PT
        JOIN Stock ST ON PT.StockSymbol = ST.StockSymbol
        WHERE PT.TransactionType = 'buy' -- Assuming dividends are received when buying
        GROUP BY PT.PortfolioID;

    """
    cursor.execute(query)

    result = format_result(cursor.fetchall())

    return result

@app.route('/total_Portfolio_val', methods=['GET'])
def total_Portfolio_val():
    query = """
        SELECT H.PortfolioID, SUM(S.Price * H.Quantity) AS TotalPortfolioValue
        FROM Holds H
        JOIN Stock S ON H.StockSymbol = S.StockSymbol
        GROUP BY H.PortfolioID;
    """
    cursor.execute(query)

    result = format_result(cursor.fetchall())

    return result

@app.route('/total_all_portfolios', methods=['GET'])
def total_all_portfolios():
    query = """
        SELECT SUM(TotalPortfolioValue) AS TotalValueOfAllPortfolios
        FROM (
            SELECT H.PortfolioID, SUM(S.Price * H.Quantity) AS TotalPortfolioValue
            FROM Holds H
            JOIN Stock S ON H.StockSymbol = S.StockSymbol
            GROUP BY H.PortfolioID
        ) AS PortfolioValues;

    """
    cursor.execute(query)

    result = format_result(cursor.fetchall())

    return result

@app.route('/total_portfolio_trans_val', methods=['GET'])
def total_portfolio_trans_val():
    query = """
    SELECT PT.PortfolioID, SUM(PT.TransactionValue) AS TotalTransactionValue
    FROM PortfolioTransaction PT
    GROUP BY PT.PortfolioID;

    """
    cursor.execute(query)
    
    result = format_result(cursor.fetchall())

    return result


"""
    3 Stock Info Queries
"""


@app.route('/get_all_stock_info', methods=['GET'])
def get_all_stock_info():
    query = """
        SELECT *
        FROM Stock;
    """
    cursor.execute(query)

    result = format_result(cursor.fetchall())

    return result

@app.route('/get_curr_price', methods=['GET'])
def get_curr_price():
    stock_symbol = request.args.get('stock_symbol', type=str)
    query = """
        SELECT S.StockSymbol, S.Price, H.PortfolioID, H.Quantity
        FROM Stock S
        JOIN Holds H ON S.StockSymbol = H.StockSymbol
        WHERE S.StockSymbol = %s;
    """
    cursor.execute(query, (stock_symbol,))

    result = format_result(cursor.fetchall())

    return result

@app.route('/get_top10_stocks', methods=['GET'])
def get_top10_stocks():
    query = """
        SELECT S.StockSymbol, S.Price
        FROM Stock S
        ORDER BY S.Price DESC
        LIMIT 10;

    """
    cursor.execute(query)

    result = format_result(cursor.fetchall())

    return result



def format_result(result):
    column_widths = [max(len(str(item)) for item in col) for col in zip(*result)]
    form_result = '\n***************Output*************\n'
    for row in result:
        formatted_row = [str(item).ljust(width) for item, width in zip(row, column_widths)]
        form_result += ' | '.join(formatted_row) + "\n"
    return form_result


if __name__ == '__main__':
    app.run(debug=True)
