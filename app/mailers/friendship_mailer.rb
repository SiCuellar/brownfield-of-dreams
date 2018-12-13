class FriendshipMailer < ApplicationMailer
  def friend(facade)
    @facade = facade
    mail(to: @facade.prospect_email, subject: "Join Turing Tutorials")
  end
end
