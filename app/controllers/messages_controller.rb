class MessagesController < ApplicationController
  before_action :authenticate_user!

  # DMのメッセージ機能

  # メッセージを作成
  def create
    if Entry.where(:user_id => current_user.id, :room_id => params[:message][:room_id]).present?
      @message = Message.new(message_params)
      @room = @message.room
      gets_entries_all_messages

      # メッセージが送信された時、相手に通知を送る
      if @message.save
        @room_member_not_me = Entry.where(room_id: @room.id).where.not(user_id: current_user.id)
        @the_id = @room_member_not_me.find_by(room_id: @room.id)
        notification = current_user.active_notifications.new(
          room_id: @room.id,
          message_id: @message.id,
          visited_id: @the_id.user_id,
          visitor_id: current_user.id,
          action: 'message'
        )

        # 自分の投稿に対するコメントの場合は、通知済みとする
        if notification.visitor_id == notification.visited_id
          notification.checked = true
        end
        notification.save if notification.valid?
      end
    else
      render 'error'
    end
  end

  # メッセージを削除する
  def destroy
    @message = Message.find(params[:id])
    @room = @message.room
    @message.destroy
    gets_entries_all_messages
  end

  # ストロングパラメーター
  private

  # チャットルームのメッセージを全て取得する
  def gets_entries_all_messages
    @messages = @room.messages.includes(:user).order("created_at asc")
    @entries = @room.entries
  end

  def message_params
    params.require(:message).permit(:user_id, :message, :room_id).merge(:user_id => current_user.id)
  end

end
