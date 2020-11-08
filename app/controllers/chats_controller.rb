class ChatsController < ApplicationController

  # before_action :set_room
  # before_action :set_chat, only: [:show]

  def create
    @chat = current_user.chats.new(chat_params)
    @chat.save
    # UserRoom.where(user_id: current_user.id, room_id: @room.id)
    # @chat = Chat.create(chat_params)
    # if @chat.save
    #   @chats = @room.chats.includes(:user).order("created_at asc")
    #   @chat = Chat.new
    #   gets_entries_all_messages
    # end
  end

  def show
    @user = User.find(params[:id])
    rooms = current_user.user_rooms.pluck(:room_id)
    user_rooms = UserRoom.find_by(user_id: @user.id, room_id: rooms)
    if user_rooms.nil?
      @room = Room.new
      @room.save
      UserRoom.create(user_id: current_user.id, room_id: @room.id)
      UserRoom.create(user_id: @user.id, room_id: @room.id)
    else
      @room = user_rooms.room
    end
    @chats = @room.chats
    @chat = Chat.new(room_id: @room.id)
  end
    # UserRoom.where(user_id: current_user.id, room_id: @room.id).present?
    # @chats = @room.chats.includes(:user).order("created_at asc")
    # @chat_new = Chat.new
    # @entries = @room.user_rooms
  # end

  # private
  # def set_room
  #   @room = Room.find_by(params[:message],params[:room_id])
  # end

  # def set_chat
  #   @chat = Chat.find(params[:id])
  # end

  # def gets_entries_all_messages
  #   @chats = @room.chats.includes(:user).order("created_at asc")
  #   @entries = @room.user_rooms
  # end

  def chat_params
    params.require(:chat).permit(:message, :room_id)
    # params.require(:chat).permit(:user_id, :message, :room_id).merge(user_id: current_user.id)
  end

end
