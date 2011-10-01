class BooleanToString < ActiveRecord::Migration
  def up
    rename_column :posts_users, :has_voted?, :has_voted
    rename_column :replies_users, :has_voted?, :has_voted

    change_column :posts_users, :has_voted, :string
    change_column :replies_users, :has_voted, :string
  end

  def down
  end
end
