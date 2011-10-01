class ChangePostIdToReplyIdInRepliesUsersTable < ActiveRecord::Migration
  def up
    rename_column :replies_users, :post_id, :reply_id
  end

  def down
    rename_column :replies_users, :reply_id, :post_id
  end
end
