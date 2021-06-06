class UsersController < ApplicationController
  before_action :authenticate_user!

  # ユーザのコントローラー

  # 詳細画面
  def show
    @user = User.find(params[:id])
    @train = @user.trains
    @trains = @train.page(params[:page]).reverse_order.per(5)
    @currentUserEntry = Entry.where(user_id: current_user.id)
    @userEntry = Entry.where(user_id: @user.id)
    if @user.id == current_user.id
    else
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.room_id == u.room_id then
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end
      if @isRoom
      else
        @room = Room.new
        @entry = Entry.new
      end
    end
  end

  # 編集画面
  def edit
    @user = User.find(params[:id])
    if @user == current_user
      render "edit"
    else
      redirect_to user_path(current_user)
    end
  end

  # ユーザ情報の更新機能
  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "ユーザ情報を更新しました。"
    else
      render :edit
    end
  end

  # ストロングパラメーター
  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

end
