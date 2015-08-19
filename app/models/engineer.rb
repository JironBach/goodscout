class Engineer < ActiveRecord::Base

  validates :name                   ,:presence            => {:message => '氏名を入力してください'}
  validates :age                    ,:presence            => {:message => '年齢を入力してください'}
  validates :job_id                 ,:presence            => {:message => '職業を選択してください'}
  validates :desire_to_work_id      ,:presence            => {:message => '仕事を探しているかどうかを選択してください'}
  validates :email                  ,:presence            => {:message => 'メールアドレスを入力してください'}
  validates :password               ,:presence            => {:message => 'パスワードを入力してください'}
  validates :password_confirmation  ,:presence            => {:message => 'パスワード確認を入力してください'}
  validates :self_introduction      ,:presence            => {:message => '自己紹介文を入力してください'}
  validates :job_history            ,:presence            => {:message => '職務経歴を入力してください'}

  has_many    :engineer_skills, dependent: :destroy
  has_many    :messages
  belongs_to  :desire_to_work
  belongs_to  :job

  paginates_per 30

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
        :job_id                 => params['job_id'],
        :desire_to_work_id      => params['desire_to_work_id'],
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

  def self.search_by_skills search_conditions

    ids_ary = []
    search_conditions.each do |search_condition|
      ids = []
      EngineerSkill.where(:skill_id => search_condition['skill_id']).each do |engineer_skill|
        ids.push(engineer_skill.engineer_id)
      end
      ids_ary.push(ids)
    end

    engineers = Engineer.where(:id => ids_ary.shift)
    ids_ary.each do |ids|
      engineers = engineers.where(:id => ids)
    end

    engineers

  end

  def self.search_by_skills_and_status search_conditions,job_ids,desire_to_work_ids
    search_by_skills(search_conditions).where(:job_id => job_ids, :desire_to_work_id => desire_to_work_ids)
  end


  has_secure_password

end
