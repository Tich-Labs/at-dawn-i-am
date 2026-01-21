class Admin::SessionsController < ApplicationController
  def new
    @login_url = params[:token] if params[:token].present?

    if params[:token].present?
      admin_user = AdminUser.authenticate_by_token(params[:token])
      if admin_user
        session[:admin_user_id] = admin_user.id
        admin_user.invalidate_token!
        redirect_to admin_root_path, notice: "Successfully logged in!"
      else
        flash.now[:alert] = "Invalid or expired magic link"
      end
    end
  end

  def create
    email = params[:email]

    # Only allow the single authorized email
    unless email == "naijeria@gmail.com"
      redirect_to admin_login_path, alert: "Unauthorized email address"
      return
    end

    admin_user = AdminUser.find_or_create_by(email: email)
    admin_user.generate_magic_link_token!

    login_url = admin_login_url(token: admin_user.authentication_token)

    if Rails.env.development?
      flash[:notice] = "Magic link created: #{login_url}"
      redirect_to admin_login_path
    else
      AdminMailer.magic_link(admin_user, login_url).deliver_now
      redirect_to admin_login_path, notice: "Magic link sent to your email!"
    end
  end

  def destroy
    session[:admin_user_id] = nil
    redirect_to admin_login_path, notice: "Logged out successfully"
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
