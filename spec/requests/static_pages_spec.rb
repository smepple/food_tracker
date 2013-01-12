require 'spec_helper'

describe "StaticPages" do
  
  describe "Home page" do
    before { visit root_path }

    subject { page }

    it { should have_content APP_NAME }
    it { should have_signup_link }
    it { should have_signin_link }
  end
end
