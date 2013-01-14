# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Category do
  
  let(:category) { Factory :category }

  subject { category }

  it { should be_valid }
  
  it { should respond_to :name }
  it { should respond_to :dishes }

  describe "when name is not present" do
    before { category.name = nil }
    it { should_not be_valid }
  end

  describe "when name is not unique" do
    let(:dup_category) { category.dup }
    subject { dup_category }
    it { should_not be_valid }
  end
end
