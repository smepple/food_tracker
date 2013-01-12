require 'spec_helper'

describe "Authentication" do

  let(:user) { Factory :user }

  before do
    visit root_path
    click_link 'Sign in'
  end

  describe "Sign in" do

    describe "sign in page" do
      subject { page }

      it { should have_page_title 'Sign in' }
      it { should have_content 'Sign in' }
      it { should have_input_field 'Username' }
      it { should have_input_field 'Password' }
      it { should have_button 'Sign in' }
    end

    describe "signing in" do

      describe "with invalid login" do

        before { click_button 'Sign in' }

        it "should display errors" do
          page.should have_error_message "Invalid username/password combination"
        end
      end

      describe "with valid login" do

        before do
          fill_in 'Username', with: user.username
          fill_in 'Password', with: user.password
          click_button 'Sign in'
        end

        it "should sign the user in" do
          page.should have_signed_in_message user.username
          page.should have_signout_link
          page.should_not have_signin_link
        end

        it "should display a success message" do
          page.should have_success_message "Welcome!"
        end

        it "should take the user to their profile page" do
          page.should have_page_title user.username
          page.should have_content user.username
        end
      end
    end
  end

  describe "Sign out" do

    before do
      fill_in 'Username', with: user.username
      fill_in 'Password', with: user.password
      click_button 'Sign in'
      click_link 'Sign out'
    end

    it "should sign the user out" do
      page.should_not have_signed_in_message user.username
      page.should have_signin_link
      page.should_not have_signout_link
    end

    it "should display a signout message" do
      page.should have_success_message "Come back soon!"
    end

    it "should take the user back to the home page" do
      page.should have_page_title ''
      page.should have_content APP_NAME
      page.should have_signup_link
      page.should have_signin_link
    end
  end
end
