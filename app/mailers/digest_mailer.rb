class DigestMailer < ActionMailer::Base
  default from: "trae@peachsquared.com"

  def daily_digest_mailer(user, digest_json_string, url)
    @current_user = user
    @digest_JSON_to_display = JSON(digest_json_string)
    @url = url
    mail(to:@current_user.email_address, subject: "eSPIRE ALERT: #{@digest_JSON_to_display.count} pending messages.")

  end


end
