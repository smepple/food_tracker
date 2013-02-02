class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_timezone

  include SessionsHelper 

  private

    def set_timezone
      Time.zone = cookies["time_zone"]
    end
end
