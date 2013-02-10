module DishesHelper

  def prep_time_in_words(prep_time)
    if prep_time < 60
      "#{prep_time} minutes"
    elsif prep_time == 60
      "1 hour"
    elsif prep_time == 90
      "1 hour 30 minutes"
    elsif prep_time == 120
      "2 hours"
    elsif prep_time == 150
      "2 hours 30 min"
    elsif prep_time == 180
      "3 hours"
    end
  end
end
