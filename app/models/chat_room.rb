class ChatRoom < ApplicationRecord
  belongs_to :user
  has_many :messages, dependent: :destroy
  has_many :questions, dependent: :destroy
  


  
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
