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