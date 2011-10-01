class CreatePostVotes < ActiveRecord::Migration
  def change
    create_table :posts_users do |t|
      t.integer :user_id
      t.integer :post_id
      t.boolean :has_voted?

      t.timestamps
    end
  end
end
