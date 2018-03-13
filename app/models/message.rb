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
      #conditional to see if the question bank has been exhausted.  if so, generate new
      if $vault[@question_index][1] == nil
        $vault[@question_index].delete_at(0) #NEED TO FIX THIS TO DROP EMPTY ARRAY
        randomize(self.chat_room)     
        @question_index = $vault.index($vault.detect{|aa| aa.include?(@room_title)}); #redefine the index here
      end
      @next_question = Message.new
      @next_question.user_id = 1
      @next_question.chat_room_id = self.chat_room.id
      @next_question.body = $vault[@question_index][1][:question] 
      @next_question.save
      #need job to check if next question exists, and if not, randomize.  need randomize function for rooms model.
    end
  }

  def timestamp
    #created_at.strftime('%H:%M:%S %d %B %Y')
    created_at.strftime('%H:%M:%S')
  end
  
  #DUPLICATE CODE WITH CHAT_ROOM MODEL
  def randomize(subject)
    @subject_questions = [subject.title]
    #put each question into a hash, then put into the @subject_questions array
    subject.questions.order("RANDOM()").each do |question|
      @append_question = { 
        :question_id => question.id,
        :question => question.question,
        :answer => question.answer
        }
      # add question hash to the array
      @subject_questions.push(@append_question)
    end
    #push subject to vault
    $vault.push(@subject_questions)
  end
  
end
