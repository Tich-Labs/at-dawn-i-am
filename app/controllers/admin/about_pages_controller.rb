class Admin::AboutPagesController < ApplicationController
  before_action :authenticate_admin!

  def show
    @about_page = AboutPage.first_or_create!
    redirect_to edit_admin_about_page_path(@about_page)
  end

  def edit
    @about_page = AboutPage.first!
  end

  def update
    @about_page = AboutPage.first!
    if @about_page.update(about_page_params)
      redirect_to about_path, notice: "About page was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def about_page_params
    params.require(:about_page).permit(:title, :content)
  end

  private

  def current_admin_user
    @current_admin_user ||= AdminUser.find_by(id: session[:admin_user_id]) if session[:admin_user_id]
  end
  helper_method :current_admin_user

  def authenticate_admin!
    redirect_to admin_login_path unless current_admin_user
  end
end
