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
          before do 
            click_button "Add dish"
          end

          it "should display errors" do
            page.should have_error_message "can't be blank"
          end
        end
      end

      describe "with valid information" do

        let(:dish) { Factory.build :dish }

        before do
          fill_in "Name", with: dish.name
          fill_in "Description", with: dish.description
          select 'Yesterday', from: 'Eat date'
          select '30 min', from: 'Prep time'
          fill_in "Category", with: "Entree"
          fill_in "Source", with: "The Baker Creek Vegan Cookbook"
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
            page.should have_content dish.dish_name
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
    it { should have_content dish.prep_time }
    it { should have_content dish.category_id }
    it { should have_content dish.source_id }
    it { should have_content dish.source_page }
  end

  # describe "editing a dish" do

  #   let(:user) { Factory :user }
  #   let(:dish) { Factory :dish }

  #   before do
  #     dish.user_id = user.id
  #     dish.save!
  #     valid_signin(user)
  #     visit dish_path(dish)
  #   end

  #   describe "before changing values" do

  #     it "should display the current dish name" do
  #       page.should have_content dish.name
  #     end
  #   end

  #   describe "after changing values", type: :request do
  #     # TODO: these tests don't work (helper methods aren't being recognized)

  #     self.use_transactional_fixtures = false

  #     it "should display the new dish name", js: true do
  #       bip_text dish, :name, "new name"
  #       page.should have_content "new name"
  #     end

  #     it "should display the new prep time", js: true do
  #       bip_select dish, :prep_time, "15 minutes"
  #       page.should have_content "15 minutes"
  #     end

  #     it "should display the new eat date", js: true do
  #       bip_select dish, :eat_date, "1 week ago"
  #       page.should have_content "Eaten 1 week ago"
  #     end

  #     it "should display the new description", js: true do
  #       bip_area dish, :description, "Lorem ipsum dolor sit amet"
  #       page.should have_content "Lorem ipsum dolor sit amet"
  #     end
  #   end
  # end
end
