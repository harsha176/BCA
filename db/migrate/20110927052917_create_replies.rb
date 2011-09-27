class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies do |t|
      t.text :reply
      t.integer :user_id
      t.integer :post_id

      t.timestamps
    end
  end
end
