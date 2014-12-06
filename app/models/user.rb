class User < ActiveRecord::Base
  attr_accessor :password
  before_save :encrypt_password

  validates_confirmation_of :password, :message => "passwords should be equal"
  validates_presence_of :password, :on => :create, :message => "can't be blank"
  validates_presence_of :password_confirmation
  validates_presence_of :email
  validates_uniqueness_of :email
  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end
  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end
  def create_auth_token
    auth_token = '123456789'
    self.update_attribute(:auth_token, auth_token)
    auth_token
  end
  def destroy_auth_token!
    self.update_attribute(:auth_token, nil)
  end
end
