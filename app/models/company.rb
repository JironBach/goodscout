class Company < ActiveRecord::Base

  validates :email                  ,:presence => {:message => 'メールアドレスを入力してください'}
  validates :company_name           ,:presence => {:message => '会社名を入力してください'}
  validates :representative_person  ,:presence => {:message => 'ご担当者様氏名を入力してください'}

  def self.create_company company_data
    begin
      Company.create(company_data)
    rescue
      puts $!
      puts $@
      puts "============DB格納エラー|Engineer#create_engineer=============="
      nil
    end
  end

  has_secure_password

end
