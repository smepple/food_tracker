class UserPresenter < BasePresenter
  presents :user

  def username
    content_tag :h1 do
      link_to user.username, user_path(user)
    end
  end

  def new_dish_button(url)
    if user.dishes.empty?
      link_to "Add a dish", url, class: "btn hint hint--right hint--always hint--info", data: { hint: "Add your first dish!" }
    else
      link_to "Add a dish", url, class: "btn"
    end
  end

  def user_dishes_list
    if user.dishes.any?
      render 'shared/dishes_list', dishes: user.dishes
    else
      content_tag :div, "You haven't added any dishes. Get cookin'!", class: "empty-state"
    end
  end

  def user_dishes_count
    if user.dishes.any?
      content_tag :cite, "Added #{pluralize(user.dishes.count, "dish")}"
    end
  end

  def member_since
    content_tag :cite, "Member since #{user.created_at.strftime('%b %Y')}"
  end
end