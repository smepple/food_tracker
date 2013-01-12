include ApplicationHelper

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
    page.should have_selector 'div.alert.alert-error', text: message
  end
end