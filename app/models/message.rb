class Message < ApplicationRecord
  belongs_to :user
  belongs_to :chat_room

  validates :body, presence: true, length: {minimum: 1, maximum: 1000}
  
  #put all rooms in a variable.
  @subjects = ChatRoom.all 
  #instantiate global hash for all qna, sorted by subject
  $vault = [] 
  
  @subjects.each do |subject|
    @subject_questions = [subject.title]
    #put each question into a hash, then put into the @subject_questions array
    subject.questions.each do |question|
      
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
  

  after_create_commit { 
    MessageBroadcastJob.perform_later(self); 
    #testing if the message is equal to the answer of the question
    @room_title = self.chat_room.title
    @question_index = $vault.index($vault.detect{|aa| aa.include?(@room_title)});
    if self.body == $vault[@question_index][1][:answer]
      MessageBroadcastJob.perform_later(Message.last)
    end
  }

  def timestamp
    #created_at.strftime('%H:%M:%S %d %B %Y')
    created_at.strftime('%H:%M:%S')
  end
end
