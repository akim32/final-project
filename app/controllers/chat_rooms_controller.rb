class ChatRoomsController < ApplicationController
  def index
    @chat_rooms = ChatRoom.all
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
    @chat_room_messages = @chat_room.messages.limit(11)
    # @chat_room_questions = @chat_room.generate_for(@chat_room)
    @message = Message.new
  end

  private

  def chat_room_params
    params.require(:chat_room).permit(:title)
  end
end