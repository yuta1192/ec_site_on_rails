class Admin::InqueriesController < ApplicationController
  def new
    @inquery = Inquery.new
    @inquery_select = Inquery.all.map{|c|[c.title, c.id]}
    @inquery_select.unshift(["新規作成",99])
  end

  def edit
    @inquery = Inquery.find(params[:id])
    @inquery_select = Inquery.all.map{|c|[c.title, c.id]}
    @inquery_select.unshift(["新規作成",99])
    @questions = Question.where(inquery_id: params[:id])
  end

  def update
    @inquery = Inquery.find(params[:id])
    ActiveRecord::Base.transaction do
      @inquery.update(title: params[:inquery][:title])
      params[:inquery][:questions].keys.each do |i|
        question = Question.find(i)
        question.update(display_order_number: params[:inquery][:questions][i][:display_order_number])
      end
    end
    question = Question.new(question: params[:inquery][:question], answer: params[:inquery][:answer], inquery_id: params[:id])
    if question.save!
      redirect_to edit_admin_inquery_path(@inquery)
    else
    end
  end

  def create
    inquery = Inquery.new(title: params[:inquery][:title])
    if inquery.save!
      redirect_to edit_admin_inquery_path(inquery)
    else
    end
  end
end
