class InqueriesController < ApplicationController
  def index
    @questions = Question.all
  end
end
