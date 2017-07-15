class StocksController < ApplicationController

  def search
    if params[:stock]                   ## will grab from URL parameters when it's search with key of stock
      @stock = Stock.find_by_ticker(params[:stock])     ## class method defined in models/stocks.rb. First, checks if it's already in our database
      @stock ||= Stock.new_from_lookup(params[:stock])  ## if doesn't exist in database, lookup [optimization to reduce data volume]
    end

    if @stock       ## if found
      #render json: @stock      #temporary to see if functionality is working
      render partial: 'lookup'
    else
      render status: :not_found, nothing: true
    end
  end

end
