class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :password
      t.string :e_mail
      t.string :admin_rights

      t.timestamps
    end
  end
end
