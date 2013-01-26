require 'spec_helper'

describe "Dishes" do
  
  let(:user) { Factory :user }
  before { valid_signin(user) }
  
  describe "adding a dish" do

    describe "from the user profile page" do

      it "should display a link to add a dish" do
        page.should have_link "Add a dish"
      end
    end

    describe "new dish page" do

      before { click_link "Add a dish" }

      subject { page }

      it { should have_page_title "New dish" }
      it { should have_content "New dish" }
      it { should have_input_field "Name" }
      it { should have_input_field "Description" }
      it { should have_input_field "Eat date" }
      it { should have_input_field "Prep time" }
      it { should have_input_field "Category" }
      it { should have_input_field "Source" }
      it { should have_button "Add dish" }
    end

    describe "adding a dish" do

      before { click_link "Add a dish" }

      describe "with invalid information" do

        it "should not create a dish" do
          expect { click_button "Add dish" }.not_to change(Dish, :count).by(1)
        end

        describe "after unsuccessful attempt to create a dish" do
          before { click_button "Add dish" }

          it "should display errors" do
            page.should have_error_message "can't be blank"
          end
        end
      end

      describe "with valid information" do

        let(:dish) { Factory.build :dish, user_id: user.id }

        before do
          fill_in "Name", with: dish.name
          fill_in "Description", with: dish.description
          select Time.now.year.to_s, from: 'dish_eat_date_1i'
          select I18n.t("date.month_names")[Time.now.month], from: 'dish_eat_date_2i'
          select Time.now.day.to_s, from: 'dish_eat_date_3i'
          select '30 min', from: 'Prep time'
          select 'Entree', from: 'Category'
          select 'The Baker Creek Vegan Cookbook', from: 'Source'
          fill_in "Source page", with: 10
        end

        it "should create a dish" do
          expect { click_button "Add dish" }.to change(Dish, :count).by(1)
        end

        describe "after successfully creating a dish" do

          before { click_button "Add dish" }

          it "should display a success message" do
            page.should have_success_message "Dish saved!"
          end

          it "should list the dish on the user profile page" do
            page.should have_content dish.name
            page.should have_content dish.eat_date
          end
        end
      end
    end
  end

  describe "viewing a dish" do
    
    let(:dish) { Factory :dish }

    before do
      visit dish_path(dish)
    end

    subject { page }

    it { should have_content dish.name }
    it { should have_content dish.description }
    it { should have_content dish.eat_date }
    it { should have_content dish.prep_time }
    it { should have_content dish.category_id }
    it { should have_content dish.source_id }
    it { should have_content dish.source_page }
  end

  describe "editing a dish" do
  end

  describe "deleting a dish" do
  end
end
