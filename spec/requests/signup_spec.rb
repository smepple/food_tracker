require 'spec_helper'

describe "Signup" do
  
  let(:user) { Factory.build :user }

  before do
    visit root_path
    click_link 'Create an account'
  end

  describe "signup page" do
    subject { page }

    it { should have_page_title 'Sign up' }
    it { should have_content 'Sign up' }
    it { should have_input_field 'Username' }
    it { should have_input_field 'Email' }
    it { should have_input_field 'Password' }
    it { should have_button 'Create account' }
  end

  describe "signing up" do

    describe "with invalid information" do

      it "should not create the user" do
        expect { click_button 'Create account' }.not_to change(User, :count).by(1)
      end


      describe "after unsuccessful signup attempt" do
        before { click_button 'Create account' }

        it "should leave the user on the signup screen" do
          page.should have_page_title 'Sign up'
          page.should have_content 'Sign up'
        end

        it "should display errors" do
          page.should have_error_message "can't be blank"
          page.should have_error_message "too short"
          page.should have_error_message "invalid"
        end
      end
    end

    describe "with valid information" do
      before do
        fill_in 'Username', with: user.username
        fill_in 'Email', with: user.email
        fill_in 'Password', with: user.password
      end

      it "should create the user" do
        expect { click_button 'Create account' }.to change(User, :count).by(1)
      end

      describe "after successful signup" do

        before { click_button 'Create account' }

        it "should display a success message" do
          page.should have_success_message 'Thanks for signing up!'
        end

        it "should redirect to the user profile page" do 
          page.should have_page_title user.username
          page.should have_content user.username
        end
      end
    end
  end
end
