class ChangeColumnsAddNotnullOnTasks < ActiveRecord::Migration[5.2]
  def change
    change_column :trains, :user_id, :integer, null: false
    change_column :trains, :line, :integer, null: false
    change_column :trains, :body, :text, null: false
    change_column :trains, :train_image_id, :string, null: false
    change_column :favorites, :user_id, :integer, null: false
    change_column :favorites, :train_id, :integer, null: false
    change_column :relationships, :follower_id, :integer, null: false
    change_column :relationships, :followed_id, :integer, null: false
    change_column :train_comments, :user_id, :integer, null: false
    change_column :train_comments, :train_id, :integer, null: false
    change_column :train_comments, :comment, :text, null: false
  end
end
