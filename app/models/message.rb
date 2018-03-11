class Message < ApplicationRecord
  belongs_to :user
  belongs_to :chat_room

  validates :body, presence: true, length: {minimum: 1, maximum: 1000}

  after_create_commit { 
    MessageBroadcastJob.perform_later(self); 
    if self.body == "123"
      MessageBroadcastJob.perform_later(Message.last)
    end
  }

  def timestamp
    #created_at.strftime('%H:%M:%S %d %B %Y')
    created_at.strftime('%H:%M:%S')
  end
end
