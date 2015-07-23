class Inquiry < ActiveRecord::Base

  validates :title      ,:presence => {:message => 'タイトルを入力してください'}
  validates :desc       ,:presence => {:message => '本文を入力してください'}

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
