# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string(255)
#  email           :string(255)
#  password_digest :string(255)
#  remember_token  :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ActiveRecord::Base
  attr_accessible :username, :email, :password

  has_secure_password

  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token

  validates_presence_of :username, :email
  validates_uniqueness_of :username, :email
  validates_format_of :email, with: VALID_EMAIL_REGEX
  validates_length_of :username, in: MIN_USERNAME_LENGTH..MAX_USERNAME_LENGTH
  validates_length_of :password, in: MIN_PASSWORD_LENGTH..MAX_PASSWORD_LENGTH

  private
  
    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
