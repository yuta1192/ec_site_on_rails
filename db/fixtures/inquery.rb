# よくある質問系（Inquery、Question）


Inquery.seed do |inq|
  inq.title = "inquery_title"
end

3.times do |i|
  Question.seed do |q|
    q.question = "question_#{i}"
    q.answer = "answer_#{i}"
    q.display_order_number = i+1
    q.inquery_id = 1
  end
end
