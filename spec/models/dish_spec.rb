# == Schema Information
#
# Table name: dishes
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  name        :string(255)
#  description :text
#  eat_date    :date
#  prep_time   :integer
#  category_id :integer
#  source_id   :integer
#  source_page :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'spec_helper'

describe Dish do
  
  let(:dish) { Factory :dish }

  subject { dish }

  it { should be_valid }

  it { should respond_to :user_id }
  it { should respond_to :name }
  it { should respond_to :description }
  it { should respond_to :eat_date }
  it { should respond_to :prep_time }
  it { should respond_to :category_id }
  it { should respond_to :source_id }
  it { should respond_to :source_page }

  describe "when user_id is not present" do
    before { dish.user_id = nil }
    it { should_not be_valid }
  end

  describe "when name is not present" do
    before { dish.name = nil }
    it { should_not be_valid }
  end

  describe "when eat_date is not present" do
    before { dish.eat_date = nil }
    it { should_not be_valid }
  end

  describe "when prep_time is not present" do
    before { dish.prep_time = nil }
    it { should_not be_valid }
  end

  describe "when category_id is not present" do
    before { dish.category_id = nil }
    it { should_not be_valid }
  end

  describe "when source_id is not present" do
    before { dish.source_id = nil }
    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { dish.name = 'a' * (MAX_DISH_NAME_LENGTH + 1) }
    it { should_not be_valid }
  end

  describe "when description is too long" do
    before { dish.description = 'a' * (MAX_DISH_DESCRIPTION_LENGTH + 1) }
    it { should_not be_valid }
  end

  describe "when prep_time is not a number" do
    before { dish.prep_time = 'a' }
    it { should_not be_valid }
  end

  describe "when source_page is not a number" do
    before { dish.source_page = 'a' }
    it { should_not be_valid }
  end

  describe "when prep_time is too short" do
    before { dish.prep_time = (MIN_DISH_PREP_TIME - 1) }
    it { should_not be_valid }
  end

  describe "when source_page is too short" do
    before { dish.source_page = (MIN_DISH_SOURCE_PAGE - 1) }
    it { should_not be_valid }
  end
end
