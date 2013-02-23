require 'spec_helper'

describe "Comments" do

  let(:user) { Factory :user }
  let(:dish) { Factory :dish }

  describe "viewing comments" do

    let(:comment) { Factory :comment }

    before do
      valid_signin user
      visit dish_path(Dish.find(comment.dish_id))
    end

    it "should show the count of comments" do
      page.should have_comment_count(1)
    end

    it "should show link to add new comment" do
      page.should have_link "Add a comment"
    end

    it "should show the commenter name" do
      page.should have_link User.find(comment.user_id).username
    end

    it "should show the comment content" do
      page.should have_content comment.content
    end

    it "should show a reply link" do
      page.should have_link "Reply"
    end
  end

  describe "adding comments" do

    describe "as a signed in user" do

      before do
        valid_signin user
        visit dish_path(dish)
      end

      describe "with invalid content" do

        before do
          click_link "Add a comment"
          fill_in "comment_content", with: ""
        end

        it "should not add a new comment" do
          expect { click_button "Post comment" }.not_to change(Comment, :count).by(1)
        end

        describe "after unsuccessful attempt to add a comment" do

          before { click_button "Post comment" }

          it "should not change the comment count" do
            page.should have_comment_count(0)
          end

          # it "should display errors" do
          #   # not working because tests are not using js
          #   page.should have_error_message "can't be blank"
          # end
        end
      end

      describe "with valid content" do

        before do
          click_link "Add a comment"
          fill_in "comment_content", with: "Test comment"
        end

        it "should add a new comment" do
          expect { click_button "Post comment" }.to change(Comment, :count).by(1)
        end

        describe "after successfully adding a comment" do

          before { click_button "Post comment" }

          it "should update the comment count" do
            page.should have_comment_count(1)
          end

          it "should display the comment" do
            page.should have_link user.username
            page.should have_content "Test comment"
            page.should have_link "Reply"
          end
        end
      end
    end
  end

  describe "replying to comments" do

    describe "as a signed in user" do

      let(:comment) { Factory :comment }

      before do
        valid_signin user
        visit dish_path(Dish.find(comment.dish_id))
      end

      describe "with invalid content" do

        before do
          click_link "Reply"
          fill_in "comment_content", with: ""
        end

        it "should not add a new reply" do
          expect { click_button "Post comment" }.not_to change(Comment, :count).by(1)
        end

        describe "after unsuccessful attempt to add reply" do

          before { click_button "Post comment" }

          it "should not change the comment count" do
            page.should have_comment_count(1)
          end

          # it "should display errors"
        end
      end

      describe "with valid content" do

        before do
          click_link "Reply"
          fill_in "comment_content", with: "test reply"
        end

        it "should add a new reply" do
          expect { click_button "Post comment" }.to change(Comment, :count).by(1)
        end

        describe "after successfully adding a reply" do

          before { click_button "Post comment" }

          it "should update the comment count" do
            page.should have_comment_count(2)
          end

          it "should display the reply" do
            page.should have_link user.username
            page.should have_content "test reply"
            page.should have_link "Reply"
          end
        end
      end
    end
  end
end
