class HomeController < ApplicationController
  def index
    # Fetch all courses so the view can display them
    @courses = Course.all
  end
end