class InqueriesController < ApplicationController
  def index
    @questions = Inquery.select(:question)
    @inqueries = Inquery.all
  end
end
