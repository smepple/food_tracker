require 'spec_helper'

describe "Sources" do
  
  let(:user) { Factory :user }
  let(:dish) { Factory.build :dish }

  before { valid_signin(user) }

  describe "creating a source" do

    describe "from the new dish form" do

      describe "when the source does not already exist" do

        before do
          click_link "Add a dish"
          fill_in "Name", with: dish.name
          fill_in "Description", with: dish.description
          select 'Yesterday', from: 'Eat date'
          select '30 min', from: 'Prep time'
          fill_in "Category", with: "Entree"
          fill_in "Source", with: "The Baker Creek Vegan Cookbook"
        end

        it "should create a new source" do
          expect { click_button "Add dish" }.to change(Source, :count).by(1)
        end
      end

      describe "when the source already exists" do

        let(:existing_source) { Factory :source }

        before do
          click_link "Add a dish"
          fill_in "Name", with: dish.name
          fill_in "Description", with: dish.description
          select 'Yesterday', from: 'Eat date'
          select '30 min', from: 'Prep time'
          fill_in "Category", with: "Entree"
          fill_in "Source", with: existing_source.name
        end

        it "should not create a new source" do
          expect { click_button "Add dish" }.not_to change(Source, :count).by(1)
        end
      end
    end
  end
end
