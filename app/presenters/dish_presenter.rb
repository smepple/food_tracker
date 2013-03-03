class DishPresenter < BasePresenter
  presents :dish

  def photo
    if dish.photo_url.present?
      render 'dishes/photo'
    end
  end

  def name
    render 'dishes/best_in_place/name'
  end

  def prep_time
    render 'dishes/best_in_place/prep_time'
  end

  def source_name
    "From #{dish.source_name}"
  end

  def eat_date
    if current_user == User.find(dish.user_id) && dish.eat_date.to_datetime > 1.week.ago
      render 'dishes/best_in_place/eat_date'
    else
      content_tag :cite, "", class: "timeago", title: dish.eat_date
    end
  end

  def description
    render 'dishes/best_in_place/description'
  end

  def comments_list
    if dish.comments.any?
      nested_comments dish.comments.arrange(order: "created_at")
    else
      content_tag :em, "No comments on this dish"
    end
  end
end