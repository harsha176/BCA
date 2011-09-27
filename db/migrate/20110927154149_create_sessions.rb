class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.string :role

      t.timestamps
    end
  end
end
