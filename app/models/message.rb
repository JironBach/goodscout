class Message < ActiveRecord::Base

  validates :title    ,:presence => {:message => 'メールアドレスを入力してください'}
  validates :desc     ,:presence => {:message => '本文を入力してください'}

  def self.select_user_messages user_type,user_id



  end

end
