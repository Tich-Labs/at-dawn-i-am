class AboutPagesController < ApplicationController
  def show
    @about_page = AboutPage.first_or_create!(
      title: "About At Dawn, I Am",
      content: "Welcome to my personal journal. This is a space for reflection, thoughts, and daily musings."
    )
  end
end
