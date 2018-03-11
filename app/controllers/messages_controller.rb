class MessagesController < ApplicationController
  def index
    @messages = Message.all.order(created_at: :desc).limit(30)
    
    render("messages/index.html.erb")
  end
end
