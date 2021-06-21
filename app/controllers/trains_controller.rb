class TrainsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  # 鉄道（投稿）のコントローラー

  # 一覧画面
  def index
    @trains = Train.page(params[:page]).reverse_order.per(8)
  end

  # 投稿詳細画面
  def show
    @train = Train.find(params[:id])
    @user = current_user
    @train_comment = TrainComment.new
  end

  # 投稿内容編集画面
  def edit
    @train = Train.find(params[:id])
    @user = current_user
    if @train.user == current_user
      render :edit
    else
      redirect_to train_path(@train), notice: "投稿者以外編集できません"
    end
  end

  # 新規投稿画面
  def new
    @train = Train.new
  end

  # 新規投稿機能
  def create
    @train = Train.new(train_params)
    @train.user_id = current_user.id
    if @train.save
      redirect_to train_path(@train), notice: "投稿できました"
    else
      render :new
    end
  end

  # 更新機能
  def update
    @train = Train.find(params[:id])
    if @train.update(train_params)
      redirect_to train_path(@train), notice: "投稿内容を更新しました"
    else
      render :edit
    end
  end

  # 削除機能
  def destroy
    @train = Train.find(params[:id])
    @train.destroy
    redirect_to user_path(@train.user), notice: "削除しました"
  end

  # ストロングパラメーター
  private

  def train_params
    params.require(:train).permit(:train_image, :line, :body)
  end
end
