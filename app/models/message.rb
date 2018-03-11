class Message < ApplicationRecord
  belongs_to :user
  belongs_to :chat_room

  validates :body, presence: true, length: {minimum: 1, maximum: 1000}
  

  

  after_create_commit { 
    MessageBroadcastJob.perform_later(self); 
    #testing if the message is equal to the answer of the first question
    @room_title = self.chat_room.title
    @question_index = $vault.index($vault.detect{|aa| aa.include?(@room_title)});
    if self.body == $vault[@question_index][1][:answer]
      #congrats method for answering correctly
      @congrats = Message.new
      @congrats.user_id = 1
      @congrats.chat_room_id = self.chat_room.id
      @congrats.body = "you got it! Good job #{self.user.name}, you now have 12 points. Waiting 3 seconds for the next question..."
      @congrats.save
      #spit next question
      sleep(3)
      #erase first question pair, which has an index of 1 in the array
      $vault[@question_index].delete_at(1)
      @next_question = Message.new
      @next_question.user_id = 1
      @next_question.chat_room_id = self.chat_room.id
      @next_question.body = $vault[0][1][:question]
      @next_question.save
      #need job to check if next question exists, and if not, randomize.  need randomize function for rooms model.
    end
  }

  def timestamp
    #created_at.strftime('%H:%M:%S %d %B %Y')
    created_at.strftime('%H:%M:%S')
  end
end
