class Admin::InqueriesController < ApplicationController
  def index
    @inquery = Inquery.new
  end

  def new
    @inquery = Inquery.new
  end

  def edit
    @inquery = Inquery.find(params[:id])
    @questions = @inquery.questions
  end

  def update
    ActiveRecord::Base.transaction do
      params[:inquery][:questions_attributes].keys.each do |i|
        question = Question.find(params[:inquery][:questions_attributes][i][:id])
        question.update(
          question: params[:inquery][:questions_attributes][i][:question],
          answer: params[:inquery][:questions_attributes][i][:answer]
        )
      end
      redirect_to edit_admin_inquery_path(params[:id])
    end
  rescue => e
    @error = "システムエラーが発生しました。管理者に問い合わせください。"
    redirect_to edit_admin_inquery_path(params[:id])
  end

  def create
    inquery = Inquery.new(title: params[:inquery][:title])
    if inquery.save
      redirect_to edit_admin_inquery_path(inquery)
    else
      render 'new' and return
    end
  end

  def select
    # セレクトボックスの選択
    if params[:select]
      if params[:inquery][:id].blank?
        @error = "新規作成か既存の質問を選択してください"
        render 'index' and return
      elsif params[:inquery][:id] == "99"
        redirect_to new_admin_inquery_path
      else
        redirect_to edit_admin_inquery_path(params[:inquery][:id])
      end
    # 削除を選択
    elsif params[:destroy]
      if params[:inquery][:id].blank?
        @error = "既存の質問を選択してください"
        render 'index' and return
      elsif params[:inquery][:id] == "99"
        @error = "既存の質問を選択してください"
        render 'index' and return
      else
        redirect_to admin_inqueries_path
      end
    end
  end
end
