class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :get_message_notifications

  require 'pp'

  def get_message_notifications
    @notifications = Notification.where(
      "notification_type = ? and user_type = ? and user_id = ? and is_done = false",
      Settings.notification_type[:message],session[:user_type],session[:user_id]
    )
  end

end
