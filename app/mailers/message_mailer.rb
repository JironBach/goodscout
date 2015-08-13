class MessageMailer < ApplicationMailer

  default from: "test@nowall.co.jp"

  def send_message_email(from_user,to_user,message)
    @title = message.title
    mail to: to_user.email, subject: "#{to_user.name}さんから#{from_user.name}さんへメッセージ:#{message.title} が届きました"
  end
  

end
