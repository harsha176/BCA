class CreateDefaultAdmin < ActiveRecord::Migration
  def change
    User.create :id=>1,
                :username=>"admin",
                :password=>User.encrypt_password("admin"),
                :admin_rights=>'true'

  end
  end