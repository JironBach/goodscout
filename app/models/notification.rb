class Notification < ActiveRecord::Base

  def self.done_notification notification_type,user_type,user_id
    Notification.where(
      "notification_type = ? and user_type = ? and user_id = ?",
      notification_type,
      user_type,
      user_id
    ).update_all(is_done: true)
  end

end
