class InqueriesController < ApplicationController
  def index
    @inqueries = Inquery.all
  end

  def search
    @inqueries = Inquery.all
    @questions = Inquery.search(params[:inquery][:key_word], params[:inquery][:title])
  end
end
