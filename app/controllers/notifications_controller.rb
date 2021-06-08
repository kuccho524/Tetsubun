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

end
