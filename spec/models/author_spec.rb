# == Schema Information
#
# Table name: authors
#
#  id         :integer          not null, primary key
#  firstname  :string(255)
#  lastname   :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Author do
  
  let(:author) { Factory :author }

  subject { author }

  it { should be_valid }

  it { should respond_to :firstname }
  it { should respond_to :lastname }
  it { should respond_to :sources }

  describe "when firstname is not present" do
    before { author.firstname = nil }
    it { should_not be_valid }
  end

  describe "when lastname is not present" do
    before { author.lastname = nil }
    it { should_not be_valid }
  end
end
