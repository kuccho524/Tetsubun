class CreateTrains < ActiveRecord::Migration[5.2]
  def change
    create_table :trains do |t|
      t.integer :user_id
      t.integer :line, default: 0
      t.text :body
      t.string :tarin_image

      t.timestamps
    end
  end
end
