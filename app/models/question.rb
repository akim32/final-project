class Question < ApplicationRecord
  belongs_to :user
  belongs_to :chat_room
  validates :question, presence: true
  validates :answer, presence: true
end
