class Message < ActiveRecord::Base

  include ApplicationHelper

  validates :title    ,:presence => {:message => 'メールアドレスを入力してください'}
  validates :desc     ,:presence => {:message => '本文を入力してください'}

  belongs_to :engineer
  belongs_to :company

  mount_uploader :attached_file, AttachedFileUploader

  paginates_per 5 

  def self.select_received_messages user_type,user_id

    my_id_type        = 'engineer_id'                  if user_type == Settings.user_type['engineer']
    my_id_type        = 'company_id'                   if user_type == Settings.user_type['company']
    opponent_type     = Settings.user_type['company']  if user_type == Settings.user_type['engineer']
    opponent_type     = Settings.user_type['engineer'] if user_type == Settings.user_type['company']
    opponent_id_type  = 'company_id'                   if user_type == Settings.user_type['engineer']
    opponent_id_type  = 'engineer_id'                  if user_type == Settings.user_type['company']

    #sql = 
    #  "SELECT * FROM (
    #    SELECT * FROM (
    #      SELECT `messages`.* FROM `messages`
    #      WHERE `messages`.`message_type` = #{opponent_type}
    #      AND `messages`.`#{my_id_type}` = #{user_id}
    #      ORDER BY created_at desc )
    #    messages GROUP BY `messages`.`#{opponent_id_type}`) 
    #    messages ORDER BY created_at desc"
    
    sql = 
      "SELECT * FROM (
        SELECT `messages`.* FROM `messages`
        WHERE `messages`.`message_type` = #{opponent_type}
        AND `messages`.`#{my_id_type}` = #{user_id}
        ORDER BY created_at desc )
       messages GROUP BY `messages`.`#{opponent_id_type}`"

      messages = Message.find_by_sql(sql)
      Message.where(id: messages.map{ |message| message.id }).order('created_at desc')

  end

  def self.select_sent_messages user_type,user_id

    my_id_type        = 'engineer_id'   if user_type == Settings.user_type['engineer']
    my_id_type        = 'company_id'    if user_type == Settings.user_type['company']
    opponent_id_type  = 'company_id'    if user_type == Settings.user_type['engineer']
    opponent_id_type  = 'engineer_id'   if user_type == Settings.user_type['company']

    sql = 
      "SELECT * FROM (
        SELECT * FROM (
          SELECT `messages`.* FROM `messages`
          WHERE `messages`.`message_type` = #{user_type}
          AND `messages`.`#{my_id_type}` = #{user_id}
          ORDER BY created_at desc  ) 
        messages GROUP BY `messages`.`#{opponent_id_type}`) 
        messages ORDER BY created_at desc"

    messages = Message.find_by_sql(sql)
    Message.where(id: messages.map{ |message| message.id }).order('created_at desc')

  end

  def self.select_message_thread user_type,user_id,opponent_id

    if user_type == Settings.user_type['engineer']
      Message.order('created_at desc').where(:engineer_id => user_id, :company_id => opponent_id)
    elsif user_type == Settings.user_type['company']
      Message.order('created_at desc').where(:engineer_id => opponent_id, :company_id => user_id)
    end

  end

  def self.read_messages messages
    messages.each do |message|
      message.is_read = true unless message.is_read
      message.save
    end
  end

end
