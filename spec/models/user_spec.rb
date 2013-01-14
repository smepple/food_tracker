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

require 'spec_helper'

describe User do

  let(:user) { Factory :user }

  subject { user }

  it { should be_valid }

  it { should respond_to :username }
  it { should respond_to :email }
  it { should respond_to :password }
  it { should respond_to :password_digest }
  it { should respond_to :remember_token }
  it { should respond_to :authenticate }
  it { should respond_to :dishes }

  describe "remember token" do
    before { user.save }
    its(:remember_token) { should_not be_blank }
  end

  describe "when username is not present" do
    before { user.username = nil }
    it { should_not be_valid }
  end

  describe "when email is not present" do
    before { user.email = nil }
    it { should_not be_valid }
  end

  describe "when password is not present" do
    before { user.password = nil }
    it { should_not be_valid }
  end

  describe "when username is not unique" do
    let(:dup_user) { Factory :user }
    before { dup_user.username = user.username }
    subject { dup_user }
    it { should_not be_valid }
  end

  describe "when email is not unique" do
    let(:dup_user) { Factory :user }
    before { dup_user.email = user.email }
    subject { dup_user }
    it { should_not be_valid }
  end

  describe "when username is too short" do
    before { user.username = 'a' * (MIN_USERNAME_LENGTH - 1) }
    it { should_not be_valid }
  end

  describe "when password is too short" do
    before { user.password = 'a' * (MIN_PASSWORD_LENGTH - 1) }
    it { should_not be_valid }
  end

  describe "when username is too long" do
    before { user.username = 'a' * (MAX_USERNAME_LENGTH + 1) }
    it { should_not be_valid }
  end

  describe "when password is too long" do
    before { user.password = 'a' * (MAX_PASSWORD_LENGTH + 1) }
    it { should_not be_valid }
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        user.email = invalid_address
        user.should_not be_valid
      end      
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        user.email = valid_address
        user.should be_valid
      end      
    end
  end
end
