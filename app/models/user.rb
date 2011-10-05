class User < ActiveRecord::Base

  has_one :session
  has_and_belongs_to_many :posts
  has_and_belongs_to_many :replies
  
  attr_accessor :clear_text_password

  validates_presence_of :username
  validates_uniqueness_of :username
  validates :clear_text_password, :presence => true, :length => {:minimum => 6}
  validates_confirmation_of :clear_text_password

  validates_presence_of :e_mail
  validates_uniqueness_of :e_mail

  def User.authenticate(name, password)
    if user = find_by_username(name)
      if user.password == encrypt_password(password)
        user
      end
    end
  end

  def clear_text_password=(password)
    @clear_text_password = password
    if password.present?
      generate_salt
      self.password = self.class.encrypt_password(password)
    end
  end

  def User.encrypt_password(password)
    if password.present?
      Digest::SHA2.hexdigest(password)
    end
  end

  private
  def generate_salt
    @salt = self.object_id.to_s + rand.to_s
  end

end