class Admin::QuestionsController < ApplicationController
  def edit
    @question = Question.find(params[:id])
  end

  def update
    @question = Question.find(params[:id])
    if @question.update(question: params[:question][:question], answer: params[:question][:answer])
      redirect_to edit_admin_inquery_path(@question.inquery_id)
    else
      render 'edit' and return
    end
  end

  def destroy
    @question = Question.find(params[:id])
    if @question.destroy
      redirect_to edit_admin_inquery_path(params[:inquery_id])
    else
      @error = "システムエラーが発生しました。管理者に問い合わせください。"
      redirect_to edit_admin_inquery_path(params[:inquery_id])
    end
  end

  def create
    @question = Question.new(inquery_id: params[:id])
    if @question.save
      redirect_to edit_admin_inquery_path(params[:id])
    else
      @error = "システムエラーが発生しました。管理者に問い合わせください。"
      redirect_to edit_admin_inquery_path(params[:id])
    end
  end
end
