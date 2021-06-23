class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.integer :visitor_id, null: false
      t.integer :visited_id, null: false
      t.integer :train_id
      t.integer :train_comment_id
      t.integer :room_id
      t.integer :message_id
      t.string :action, default: '', null: false
      t.boolean :checked, default: false

      t.timestamps
    end

    add_index :notifications, :visitor_id
    add_index :notifications, :visited_id
    add_index :notifications, :train_id
    add_index :notifications, :train_comment_id
    add_index :notifications, :message_id
    add_index :notifications, :room_id
  end
end
