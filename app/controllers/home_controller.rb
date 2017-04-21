
class HomeController < ApplicationController

  def index
    if current_user
      @devices = current_user.devices.all
    end
  end

  def phone

  end
end