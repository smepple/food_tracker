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
          select Time.now.year.to_s, from: 'dish_eat_date_1i'
          select I18n.t("date.month_names")[Time.now.month], from: 'dish_eat_date_2i'
          select Time.now.day.to_s, from: 'dish_eat_date_3i'
          select '30 min', from: 'Prep time'
          fill_in "Category", with: "Entree"
          select 'The Baker Creek Vegan Cookbook', from: 'Source'
          fill_in "Source page", with: 10
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
          select Time.now.year.to_s, from: 'dish_eat_date_1i'
          select I18n.t("date.month_names")[Time.now.month], from: 'dish_eat_date_2i'
          select Time.now.day.to_s, from: 'dish_eat_date_3i'
          select '30 min', from: 'Prep time'
          fill_in "Category", with: existing_category.name
          select 'The Baker Creek Vegan Cookbook', from: 'Source'
          fill_in "Source page", with: 10
        end

        it "should not create a new category" do
          expect { click_button "Add dish" }.not_to change(Category, :count).by(1)
        end
      end
    end
  end
end
