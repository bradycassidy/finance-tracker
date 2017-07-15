class Stock < ApplicationRecord

  def self.find_by_ticker(ticker_symbol)                     ## returns the first instance of this from my database if the ticker exists there
    where(ticker: ticker_symbol).first
  end


  def self.new_from_lookup(ticker_symbol)
    looked_up_stock = StockQuote::Stock.quote(ticker_symbol)
    return nil unless looked_up_stock.name                    ## prevents it from blowing up if search a stock that doesn't exist

    new_stock = new(ticker: looked_up_stock.symbol, name: looked_up_stock.name)
    new_stock.last_price = new_stock.price
    new_stock     ## returns new_stock
  end


  def price
    closing_price = StockQuote::Stock.quote(ticker).close
    return "#{closing_price} (Closing)" if closing_price      # returns if exists (not nil)

    opening_price = StockQuote::Stock.quote(ticker).open
    return "#{opening_price} (Opening)" if opening_price      # otherwise returns this if it exists (not nil)

    "Unavailable"                                             # otherwise returns "unavailable" if neither of those two exist
  end



end
