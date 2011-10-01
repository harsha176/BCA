class PostsUsersUpdatedPrimaryKey < ActiveRecord::Migration
  def up
    drop_table(:posts_users)
    create_table :posts_users, :id=>false do |t|
      t.integer :user_id
      t.integer :post_id
      t.boolean :has_voted?

      t.timestamps
    end
  end

  def down
  end
end
