require 'spec_helper'

describe "User pages" do

  let(:user) { Factory :user }

  before { valid_signin user }
  
  describe "user home page" do

    it "should display the username in the page title" do
      page.should have_page_title user.username
    end

    it "should display the username" do
      page.should have_selector "h1", text: user.username
    end

    describe "when the user has not created any dishes" do

      it "should display a helper tooltip on the new dish button" do
        page.should have_link "Add a dish", class: "hint--right hint--always hint--info"
        page.should have_link "Add a dish", "data-hint" => "Add your first dish!"
      end

      it "should display empty state content in the dishes list" do
        page.should have_content "You haven't added any dishes. Get cookin'!"
      end
    end
  end
end
