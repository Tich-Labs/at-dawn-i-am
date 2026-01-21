class HomeController < ApplicationController
  def index
    @latest_entries = Entry.chronological.limit(3)
  end
end
