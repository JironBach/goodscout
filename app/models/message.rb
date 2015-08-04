class Message < ActiveRecord::Base

  validates :title    ,:presence => {:message => 'メールアドレスを入力してください'}
  validates :desc     ,:presence => {:message => '本文を入力してください'}

  belongs_to :engineer
  belongs_to :company

  def self.select_received_messages user_type,user_id

    if user_type == Settings.user_type['engineer']
      Message.where(:message_type => Settings.message_type['from_company'],:engineer_id => user_id)
    elsif user_type == Settings.user_type['company']
      Message.where(:message_type => Settings.message_type['from_engineer'],:company_id => user_id)
    end

  end

  def self.select_sent_messages user_type,user_id

    if user_type == Settings.user_type['engineer']
      Message.where(:message_type => Settings.message_type['from_engineer'],:engineer_id => user_id)
    elsif user_type == Settings.user_type['company']
      Message.where(:message_type => Settings.message_type['from_company'],:company_id => user_id)
    end

  end

  def self.select_message_thread user_id,opponent_id

    Message.where(:engineer_id => user_id, :company_id => opponent_id)

  end

end
