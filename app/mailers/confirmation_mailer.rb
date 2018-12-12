class ConfirmationMailer < ApplicationMailer
  def valid(current_user)
    @user = current_user
    @link = "#{email_validation_url}?#{current_user.id}"
    mail(to: @user.email, subject: "Activate Turing Tutorials Account!")
  end
end
