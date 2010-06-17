class UserMailer < ActionMailer::Base

  def reset_notification(user, request)
    setup_email(user)
    subject         'Reset your p-a-s-s-w-o-r-d'
    @body[:url]  =  url_prefix(request) + "/reset/#{user.perishable_token}"
  end

protected

  def url_prefix(request)
    "#{request.protocol}#{request.host_with_port}"
  end

  def setup_email(user)
    recipients    user.email
    sent_on       Time.now
    from          Option.get("Email")
    @body[:user] = user
  end

end
