class UserPresenter < BasePresenter
  presents :user

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
      content_tag :cite, "You haven't added any dishes. Get cookin'!"
    end
  end
end