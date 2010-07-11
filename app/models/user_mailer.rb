class UserMailer < ActionMailer::Base
  def signup_notification(user)
    setup_email(user)
    @subject    += 'Please activate your new account'
    @body[:url]  = "http://#{user.subdomain + '.' + SITE_DOMAIN}/activate/#{user.activation_code}"
  end
  
  def activation(user)
    setup_email(user)
    @subject    += 'Your account has been activated!'
    @body[:url]  = "http://#{user.subdomain + '.' + SITE_DOMAIN}/"
  end
  
  def forgot_password(user)
     setup_email(user,'You have requested to change your password')
     @body[:url]  = "http://#{user.subdomain + '.' + SITE_DOMAIN}/reset_password/#{user.password_reset_code}"
   end

   def reset_password(user)
     setup_email(user,'Your password has been reset.')
   end
  
  protected
    def setup_email(user, subj = nil)
      @recipients  = "#{user.email}"
      @from        = "GaugedCampaigns"
      @subject     = "[#{SITE_NAME}] #{subj}"
      @sent_on     = Time.now
      @body[:user] = user
    end
end