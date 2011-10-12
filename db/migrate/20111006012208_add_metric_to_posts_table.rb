class AddMetricToPostsTable < ActiveRecord::Migration
  def change
    add_column :posts, :metric, :float
  end
end
