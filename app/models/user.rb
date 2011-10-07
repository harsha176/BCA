#
# This model is used to store user information. Every registered user has entry in Users table.
# It performs hashing before storing the password and it provides methods to authenticate, encrypt and generate_salt methods.
#

class User < ActiveRecord::Base
  # A user can have many posts and replies.

  has_one :session
  has_many :posts, :dependent=>:destroy
  has_and_belongs_to_many :posts
  has_and_belongs_to_many :replies


  #Email validation regular expression 
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  # Creating a virtual attribute fetching clear_text_password from the user.
  attr_accessor :clear_text_password;

  # Performing basic validations including password field length which should be atleast six characters in length.
  validates_presence_of :username
  validates_uniqueness_of :username
  validates :clear_text_password, :presence => true, :length => {:minimum => 6}
  validates_confirmation_of :clear_text_password

  validates_presence_of :e_mail
  validates_uniqueness_of :e_mail
  validates :e_mail, :presence => true,
            :format => {:with => email_regex}


  # This method is used to authenticate a user while login.
  def User.authenticate(name, password)
    # It first checks if user is already registered and then encrypts given password and checks it with encrypted value in database.
    if user = find_by_username(name)
      if user.password == encrypt_password(password)
        user
      end
    end
  end

  # Virtual attribute
  def clear_text_password=(password)
    @clear_text_password = password
    if password.present?
      generate_salt
      self.password = self.class.encrypt_password(password)
    end
  end

  # This method encrypts the given password using SHA2 digest algorithm.
  def User.encrypt_password(password)
    if password.present?
      Digest::SHA2.hexdigest(password)
    end
  end

  private
  # This method generates salt and can be used if more stronger security is required. If used then it uses HMAC algorithm with generated salt as the key.
  def generate_salt
    @salt = self.object_id.to_s + rand.to_s
  end

end