class PostVotesTableRenameToPostUsers < ActiveRecord::Migration
  def up
   # rename_table(:post_votes, :posts_users)
   # rename_table(:reply_votes, :replies_users)
  end

  def down
   # rename_table(:posts_users, :post_votes)
   # rename_table(:replies_users, :reply_votes)
  end
end
