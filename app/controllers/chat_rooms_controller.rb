class ChatRoomsController < ApplicationController
  def index
    @chat_rooms = ChatRoom.joins(:questions).group('chat_room_id')
  end

  def new
    @chat_room = ChatRoom.new
  end

  def create
    @chat_room = current_user.chat_rooms.build(chat_room_params)
    if @chat_room.save
      flash[:success] = 'Chat room added!'
      redirect_to chat_rooms_path
    else
      render 'new'
    end
  end

  def show
    @chat_room = ChatRoom.includes(:messages).find_by(id: params[:id])
    @chat_room_messages = @chat_room.messages.order(created_at: :desc).limit(12).reverse
    @message = Message.new
    #set variable for current question
    @room_title = @chat_room.title
    #seeing if the game questions exist in the vault.  if not, randomize.
    if $vault.detect{|aa| aa.include?(@room_title)}
      @question_index = $vault.index($vault.detect{|aa| aa.include?(@room_title)});
      @current_question = $vault[@question_index][1][:question]
      else
      @chat_room.randomize(@chat_room)
      @question_index = $vault.index($vault.detect{|aa| aa.include?(@room_title)});
      @current_question = $vault[@question_index][1][:question]
      # @current_question = "There are no questions in the vault"
    end
  end

  private

  def chat_room_params
    params.require(:chat_room).permit(:title, :description)
  end
end