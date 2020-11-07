class ChatsController < ApplicationController
  
  before_action :set_room
  before_action :set_chat, only: [:show]
  
  def create
    UserRoom.where(user_id: current_user.id, room_id: @room.id)
    @chat = Chat.create(chat_params)
    if @chat.save
      @chat = Chat.new
      gets_entries_all_messages
    end
  end

  def show
    UserRoom.where(user_id: current_user.id, room_id: @room.id).present?
    @chats = @room.chats.includes(:user).order("created_at asc")
    @chat = Chat.new
    @entries = @room.user_rooms
  end
  
  private
  def set_room
    @room = Room.find(params[:chat][room_id])
  end
  
  def set_chat
    @chat = Chat.find(params[:id])
  end
  
  def gets_entries_all_messages
    @chats = @room.chats.includes(:user).order("created_at asc")
    @entries = @room.user_rooms
  end
  
  def chat_params
    params.require(:chat).permit(:user_id, :chat, :room_id).merge(user_id: current_user.id)
  end
  
end
