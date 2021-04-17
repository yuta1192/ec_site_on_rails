class Question < ApplicationRecord
  # inquery(よくある質問)のを親にもつ

  belongs_to :inquery

  # validates :question, presence: true
  # validates :answer, presence: true
end
