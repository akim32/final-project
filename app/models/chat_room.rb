class ChatRoom < ApplicationRecord
  belongs_to :user
  has_many :messages, dependent: :destroy
  has_many :questions, dependent: :destroy
  
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

  
  def generate_for(room_id)
    @qna = ChatRoom.find_by(:id => room_id).questions.shuffle.first
    return { :question => @qna.question, :answer => @qna.answer }
    #if @subject.state = 0
      #BOT LOGIC HERE
     # @subject.questions.shuffle
      #@question = @subject.questions.first.question
      #@answer = @subject.questions.first.answer
    #end
  end

end
