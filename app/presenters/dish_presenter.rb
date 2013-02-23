class DishPresenter < BasePresenter
  presents :dish

  def comments_list
    if dish.comments.any?
      nested_comments dish.comments.arrange(order: "created_at")
    else
      content_tag :em, "No comments on this dish"
    end
  end

  def photo
    if dish.photo_url.present?
      render 'dishes/photo'
    end
  end
end