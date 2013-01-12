require 'spec_helper'

describe "Authorization" do

  let(:user) { Factory :user }
  let(:another_user) { Factory :user }
  
  describe "home page" do

    describe "as a non-signed in user" do

      before { visit root_path }

      it "should render the public home page" do
        page.should have_page_title ''
        page.should have_content APP_NAME
        page.should have_signup_link
        page.should have_signin_link
      end
    end

    describe "as a signed in user" do

      before do
        valid_signin user
        visit root_path
      end

      it "should redirect to the user profile page" do
        page.should have_page_title user.username
        page.should have_content user.username
        page.should have_signed_in_message user.username
        page.should have_signout_link
        page.should_not have_signin_link
      end
    end
  end

  describe "sign in page" do

    describe "as a non-signed in user" do

      before { visit signin_path }

      it "should render the signin page" do
        page.should have_page_title 'Sign in'
        page.should have_content 'Sign in'
        page.should have_input_field 'Username'
        page.should have_input_field 'Password'
        page.should have_button 'Sign in'
      end
    end

    describe "as a signed in user" do

      before do
        valid_signin user
        visit signin_path
      end

      it "should inform the user they are already signed in" do
        page.should have_warning_message "You're already signed in"
      end

      it "should redirect to the user profile page" do
        page.should have_page_title user.username
        page.should have_content user.username
        page.should have_signed_in_message user.username
        page.should have_signout_link
        page.should_not have_signin_link
      end
    end
  end

  describe "signup page" do

    describe "as a non-signed in user" do

      before { visit signup_path }

      it "should render the signup page" do
        page.should have_page_title 'Sign up'
        page.should have_content 'Sign up'
        page.should have_input_field 'Username'
        page.should have_input_field 'Email'
        page.should have_input_field 'Password'
        page.should have_button 'Create account'
      end
    end

    describe "as a signed in user" do

      before do
        valid_signin user
        visit signup_path
      end

      it "should inform the user they're already signed up" do
        page.should have_warning_message "You're already signed up"
      end

      it "should redirect to the user profile page" do
        page.should have_page_title user.username
        page.should have_content user.username
        page.should have_signed_in_message user.username
        page.should have_signout_link
        page.should_not have_signin_link
      end
    end
  end

  describe "user profile page" do

    describe "as a non-signed in user" do

      before { visit user_path(user) }

      it "should ask the user to sign in" do
        page.should have_warning_message "Please sign in"
      end

      it "should redirect to the signin page" do
        page.should have_page_title 'Sign in'
        page.should have_content 'Sign in'
        page.should have_input_field 'Username'
        page.should have_input_field 'Password'
        page.should have_button 'Sign in'
      end

      describe "when attempting to visit a protected page" do
        before do
          # visit user_path(user)
          fill_in 'Username', with: user.username
          fill_in 'Password', with: user.password
          click_button 'Sign in'
        end

        describe "after signing in" do

          it "should render the desired protected page" do
            page.should have_page_title user.username
            page.should have_content user.username
            page.should have_signed_in_message user.username
            page.should have_signout_link
            page.should_not have_signin_link
          end
        end
      end
    end

    describe "as a signed in user" do

      describe "as another user" do

        before do
          valid_signin another_user
          visit user_path(user)
        end

        it "should inform the user they can't access this page" do
          page.should have_warning_message "You don't have permission to access this page"
        end

        it "should redirect to their own user profile page" do
          page.should have_page_title another_user.username
          page.should have_content another_user.username
          page.should have_signed_in_message another_user.username
          page.should have_signout_link
          page.should_not have_signin_link
        end
      end

      describe "as the correct user" do

        before do
          valid_signin user
          visit user_path(user)
        end

        it "should render the user profile page" do
          page.should have_page_title user.username
          page.should have_content user.username
          page.should have_signed_in_message user.username
          page.should have_signout_link
          page.should_not have_signin_link
        end
      end
    end
  end
end
