class NotificationsController < ApplicationController
  before_action :authenticate_user!

  # 通知機能のコントローラー

  # 通知一覧画面
  def index
    @notifications = current_user.passive_notifications.page(params[:page]).per(10)
    @notifications.where(checked: false).each do |notification|
      notification.update_attributes(checked: true)
    end
  end

  #通知を全削除
  def destroy_all
    @notifications = current_user.passive_notifications.destroy_all
    redirect_to root_path, notice: "通知を削除しました。"
  end

end
