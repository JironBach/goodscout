class Inquiry < ActiveRecord::Base

  validates :company_name           ,:presence => {:message => '会社名を入力してください'}
  validates :representative_person  ,:presence => {:message => '代表者名を入力してください'}
  validates :company_email          ,:presence => {:message => 'メールアドレスを入力してください'}
  validates :how_to_reply           ,:presence => {:message => '返信方法を入力してください'}
  validates :company_phone_number   ,:presence => {:message => '電話番号を入力してください'}
  validates :title                  ,:presence => {:message => 'タイトルを入力してください'}
  validates :desc                   ,:presence => {:message => '本文を入力してください'}

  def self.create_inquiry params,company_id
    begin
      Inquiry.create(
        :title                  => params['title'],
        :desc                   => params['desc'],
        :how_to_reply           => params['how_to_reply'],
        :company_id             => company_id
      )
    rescue
      puts $!
      puts $@
      puts "============DB格納エラー|Inquiry#create_inquiry=============="
      nil
    end
  end

end
