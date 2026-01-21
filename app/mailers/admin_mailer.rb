class AdminMailer < ApplicationMailer
  default from: "admin@atdawniam.com"

  def magic_link(admin_user, login_url)
    @admin_user = admin_user
    @login_url = login_url
    @expires_at = admin_user.token_expires_at

    mail(to: @admin_user.email, subject: "Admin Magic Login Link")
  end
end
