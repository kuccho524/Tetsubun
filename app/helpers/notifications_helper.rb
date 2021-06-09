module NotificationsHelper

  def unchecked_notifications
    @notifications = current_user.passive_notifications.where(checked: false)
  end

  def notification_form(notification)
    @visitor = notification.visitor
    your_train = link_to 'あなたの投稿', train_path(notification), style: "font-weight: bold;"
    @comment = nil

    #notification.actionがfollowかfavoriteかcommentか
    case notification.action
      when "follow" then
        tag.a(notification.visitor.name, href: user_path(@visitor), style: "font-weight: bold;")+"があなたをフォローしました"
      when "favorite" then
        @train = notification.train_id
        @user = @train.nser
        tag.a(notification.visitor.name, href: user_path(@visitor), style: "font-weight: bold;")+"が"+tag.a('あなたの投稿', href: train_path(notification.train_id), style: "font-weight: bold;")+"にいいねしました"
      when "train_comment" then
        @visiter_train_comment = notification.train_comment_id
        @train_comment = TrainComment.find_by(id: @visiter_train_comment)&.content
        tag.a(@visitor.name, href: user_path(@visitor), style: "font-weight: bold;")+"が"+tag.a('あなたの投稿', href: train_path(notification.train_id), style: "font-weight: bold;")+"にコメントしました"
    end
  end
end
