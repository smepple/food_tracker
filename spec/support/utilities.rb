include ApplicationHelper

def valid_signin(user)
  visit root_path
  click_link "Sign in"
  fill_in "Username", with: user.username
  fill_in "Password", with: user.password
  click_button "Sign in"
end

RSpec::Matchers.define :have_signup_link do
  match do |page|
    page.should have_link 'Create an account'
  end
end

RSpec::Matchers.define :have_signin_link do
  match do |page|
    page.should have_link 'Sign in'
  end
end

RSpec::Matchers.define :have_signout_link do
  match do |page|
    page.should have_link 'Sign out'
  end
end

RSpec::Matchers.define :have_signed_in_message do |username|
  match do |page|
    page.should have_content "Signed in as #{username}"
  end
end

RSpec::Matchers.define :have_input_field do |label|
  match do |page|
    page.should have_selector 'input', label: label
  end
end

RSpec::Matchers.define :have_page_title do |title|
  match do |page|
    page.should have_selector 'title', text: full_title(title)
  end
end

RSpec::Matchers.define :have_error_message do |message|
  match do |page|
    page.should have_selector 'div.alert', text: message
  end
end

RSpec::Matchers.define :have_clientside_error_message do |message|
  match do |page|
    page.should have_selector 'ul.parsley-error-list li', text: message
  end
end

RSpec::Matchers.define :have_success_message do |message|
  match do |page|
    page.should have_selector 'div.alert.alert-success', text: message
  end
end

RSpec::Matchers.define :have_warning_message do |message|
  match do |page|
    page.should have_selector 'div.alert.alert-notice', text: message
  end
end

RSpec::Matchers.define :have_comment_count do |count|
  match do |page|
    if count == 1
      string = "comment"
    else
      string = "comments"
    end
    page.should have_selector 'h3.comments_count', text: "#{count} #{string}"
  end
end