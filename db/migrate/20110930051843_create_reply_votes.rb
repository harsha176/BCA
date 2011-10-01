class CreateReplyVotes < ActiveRecord::Migration
  def change
    create_table :replies_users do |t|
      t.integer :user_id
      t.integer :reply_id
      t.boolean :has_voted?

      t.timestamps
    end
  end
end
