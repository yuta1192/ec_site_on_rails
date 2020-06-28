class Admin::QuestionsController < ApplicationController
  def edit
    @question = Question.find(params[:id])
  end

  def destroy
  end
end
