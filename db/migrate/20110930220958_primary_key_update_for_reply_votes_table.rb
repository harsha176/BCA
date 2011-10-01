class PrimaryKeyUpdateForReplyVotesTable < ActiveRecord::Migration
 def up
     drop_table(:replies_users)
      create_table :replies_users, :id=>false do |t|
      t.integer :user_id
      t.integer :post_id
      t.boolean :has_voted?

      t.timestamps
  end

  def down
  end
  end
end
