class ChatRoom < ApplicationRecord
  belongs_to :user
  has_many :messages, dependent: :destroy
  has_many :questions, dependent: :destroy
  
  #put all rooms in a variable.
  @subjects = ChatRoom.all 
  #instantiate global hash for all qna, sorted by subject
  $vault = [] 
  
  #for each chat room with a state of 1
  @subjects.where(:state => 0).each do |subject|
    @subject_questions = [subject.title]
    #put each APPROVED question (state = 1) into a hash, then put into the @subject_questions array
    subject.questions.where(:state => 1).order("RANDOM()").each do |question|
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
  
  #DUPLICATE CODE W MESSAGE MODEL => delete later if no problems...
  # #method to reshuffle questions for a subject after they have been exhausted
  # def randomize(subject)
  #   @subject_questions = [subject.title]
  #   #put each question into a hash, then put into the @subject_questions array
  #   subject.questions.order("RANDOM()").each do |question|
  #     @append_question = { 
  #       :question_id => question.id,
  #       :question => question.question,
  #       :answer => question.answer
  #       }
  #     # add question hash to the array
  #     @subject_questions.push(@append_question)
  #   end
  #   #push subject to vault
  #   $vault.push(@subject_questions)
  # end
  

end
