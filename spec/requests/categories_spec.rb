require 'spec_helper'

describe "Categories" do
  
  let(:user) { Factory :user }
  let(:dish) { Factory.build :dish }

  before { valid_signin(user) }

  describe "creating a category" do

    describe "from the new dish form" do

      describe "when the category does not already exist" do

        before do
          click_link "Add a dish"
          fill_in "Name", with: dish.name
          fill_in "Description", with: dish.description
          select 'Yesterday', from: 'Eat date'
          select '30 min', from: 'Prep time'
          fill_in "Category", with: "Entree"
          fill_in "Source", with: "The Baker Creek Vegan Cookbook"
        end

        it "should create a new category" do
          expect { click_button "Add dish" }.to change(Category, :count).by(1)
        end
      end

      describe "when the category already exists" do

        let(:existing_category) { Factory :category }

        before do
          click_link "Add a dish"
          fill_in "Name", with: dish.name
          fill_in "Description", with: dish.description
          select 'Yesterday', from: 'Eat date'
          select '30 min', from: 'Prep time'
          fill_in "Category", with: existing_category.name
          fill_in "Source", with: "The Baker Creek Vegan Cookbook"
        end

        it "should not create a new category" do
          expect { click_button "Add dish" }.not_to change(Category, :count).by(1)
        end
      end
    end
  end
end
