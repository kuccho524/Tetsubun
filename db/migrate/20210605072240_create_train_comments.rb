class CreateTrainComments < ActiveRecord::Migration[5.2]
  def change
    create_table :train_comments do |t|
      t.integer :user_id
      t.integer :train_id
      t.text :comment

      t.timestamps
    end
  end
end
