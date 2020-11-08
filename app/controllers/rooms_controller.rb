# class RoomsController < ApplicationController

#   before_action :authenticate_user!

#   def create
#     @room = Room.create
#     @joinCurrentUser = UserRoom.create(user_id: current_user.id, room_id: @room.id)
#     @joinUser = UserRoom.create(join_room_params)
#     redirect_to chat_path(chat.id)
#   end

#   private
#   def join_room_params
#     params.require(:user_room).permit(:user_id, :room_id).merge(room_id: @room.id)
#   end

# end
