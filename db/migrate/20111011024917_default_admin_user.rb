class DefaultAdminUser < ActiveRecord::Migration
    def change
    User.create :username=>"admin",
                :password=>User.encrypt_password("adminadmin"),
                :e_mail=>'admin@admin.com',
                :admin_rights=>'true'
    end
end
