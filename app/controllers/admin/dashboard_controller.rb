class Admin::DashboardController < ApplicationController
  before_action :authenticate_admin!

  private

  def current_admin_user
    @current_admin_user ||= AdminUser.find_by(id: session[:admin_user_id]) if session[:admin_user_id]
  end
  helper_method :current_admin_user

  def authenticate_admin!
    redirect_to admin_login_path unless current_admin_user
  end

  def index
    @entries_count = Entry.count
    @last_entry = Entry.order(date: :desc).first
  end
end
