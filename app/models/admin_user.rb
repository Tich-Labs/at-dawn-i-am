class AdminUser < ApplicationRecord
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP },
                   inclusion: { in: [ "naijeria@gmail.com" ], message: "Only authorized email address allowed" }

  def generate_magic_link_token!
    self.authentication_token = SecureRandom.urlsafe_base64(32)
    self.token_expires_at = 15.minutes.from_now
    save!
  end

  def token_expired?
    token_expires_at < Time.current
  end

  def invalidate_token!
    update!(authentication_token: nil, token_expires_at: nil)
  end

  def self.authenticate_by_token(token)
    return nil if token.blank?

    admin_user = find_by(authentication_token: token)
    return nil unless admin_user
    return nil if admin_user.token_expired?

    admin_user
  end
end
