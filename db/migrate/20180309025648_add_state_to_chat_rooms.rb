class AddStateToChatRooms < ActiveRecord::Migration[5.0]
  def change
    add_column :chat_rooms, :state, :integer, :default => 0
  end
end
