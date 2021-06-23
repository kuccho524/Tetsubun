class RoomsController < ApplicationController
  before_action :authenticate_user!

  # DMのチェットルームのコントローラー

  # チャットルーム一覧画面
  def index
    @rooms = current_user.rooms.joins(:messages).includes(:messages).order("messages.created_at DESC")
  end

  # チャットルーム
  def show
    @rooms = current_user.rooms.joins(:messages).includes(:messages).order("messages.created_at DESC")
    @room = Room.find(params[:id])
    if Entry.where(:user_id => current_user.id, :room_id => @room.id).present?
      @messages = @room.messages
      @message = Message.new
      @entries = @room.entries
    else
      redirect_back(fallback_location: root_path)
    end
  end

  # チャットルーム作成
  def create
    @room = Room.create
    @entry1 = Entry.create(:room_id => @room.id, :user_id => current_user.id)
    @entry2 = Entry.create(room_params)
    redirect_to room_path(@room.id)
  end

  private

  def room_params
    params.require(:entry).permit(:user_id, :room_id).merge(:room_id => @room.id)
  end
end
