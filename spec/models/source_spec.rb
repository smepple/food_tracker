# == Schema Information
#
# Table name: sources
#
#  id         :integer          not null, primary key
#  author_id  :integer
#  name       :string(255)
#  url        :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Source do
  
  let(:source) { Factory :source }

  subject { source }

  it { should be_valid }

  it { should respond_to :author_id }
  it { should respond_to :name }
  it { should respond_to :url }
  it { should respond_to :dishes }

  describe "when author_id is not present" do
    before { source.author_id = nil }
    it { should_not be_valid }
  end

  describe "when name is not present" do
    before { source.name = nil }
    it { should_not be_valid }
  end
end
