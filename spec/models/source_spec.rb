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

  describe "when url format is invalid" do
    it "should be invalid" do
      urls = %w[subdomain.subdomain.domain.com 
                sub.domain 
                https://sub.domain]
      urls.each do |invalid_url|
        source.url = invalid_url
        source.should_not be_valid
      end      
    end
  end

  describe "when url format is valid" do
    it "should be valid" do
      urls = %w[http://www.test.com http://subdomain.test.com
                https://subdomain.test.com/url/parameters 
                http://www.test.com/query?parameters=query]
      urls.each do |valid_url|
        source.url = valid_url
        source.should be_valid
      end      
    end
  end
end
