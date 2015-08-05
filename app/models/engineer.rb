class Engineer < ActiveRecord::Base

  validates :email                  ,:presence => {:message => 'メールアドレスを入力してください'}
  validates :name                   ,:presence => {:message => '会社名を入力してください'}
  validates :password               ,:presence => {:message => 'パスワードを入力してください'}
  validates :password_confirmation  ,:presence => {:message => 'パスワード確認を入力してください'}
  validates :self_introduction      ,:presence => {:message => '自己紹介文を入力してください'}
  validates :age                    ,:presence => {:message => '年齢を入力してください'}
  validates :job_history            ,:presence => {:message => '職務経歴を入力してください'}

  has_many :engineer_skills, dependent: :destroy
  has_many :messages

  mount_uploader :image, ImageUploader 

  def self.create_engineer params,status,is_invitation_enabled

    #begin

      engineer = Engineer.create(
        :name                   => params['name'],
        :email                  => params['email'],
        :password               => params['password'],
        :password_confirmation  => params['password_confirmation'],
        :self_introduction      => params['self_introduction'],
        :living_place           => params['living_place'],
        :age                    => params['age'],
        :phone_number           => params['phone_number'],
        :status                 => status,
        :image                  => params['image'],
        :job_history            => params['job_history'],
        :is_invitation_enabled  => is_invitation_enabled,
      )


    #rescue
    #  puts $!
    #  puts $@
    #  puts "============DB格納エラー|Engineer#create_engineer=============="
    #  nil
    #end

  end

  def self.select_engineer_with_skills
    Engineer.includes(:engineer_skills)
  end

  has_secure_password

end
