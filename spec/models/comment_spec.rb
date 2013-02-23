# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  dish_id    :integer
#  user_id    :integer
#  content    :text
#  ancestry   :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Comment do
  
  let(:comment) { Factory :comment }

  subject { comment }

  it { should respond_to :dish_id }
  it { should respond_to :user_id }
  it { should respond_to :content }
  it { should respond_to :ancestry }

  describe "when dish_id is not present" do
    before { comment.dish_id = nil }
    it { should_not be_valid }
  end

  describe "when user_id is not present" do
    before { comment.user_id = nil }
    it { should_not be_valid }
  end

  describe "when content is not present" do
    before { comment.content = nil }
    it { should_not be_valid }
  end

  describe "when content is too long" do
    before { comment.content = "a" * (MAX_COMMENT_LENGTH + 1) }
    it { should_not be_valid }
  end
end
