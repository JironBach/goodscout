# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

100.times do |i|
  Engineer.create(
    :name                   => "柳澤 直:#{i + 1}",
    :email                  => "n.yanagisawa#{i + 1}@nowall.co.jp",
    :password               => "hogehoge",
    :password_confirmation  => "hogehoge",
    :self_introduction      => "自己紹介文なり",
    :living_place           => "湘南台",
    :age                    => 21,
    :image                  => "default_profile_img.jpg",
    :phone_number           => '09096760070',
    :job_id                 => rand(1..3),
    :desire_to_work_id      => rand(1..3),
    :job_history            => '内緒だお',
    :is_invitation_enabled  => true,
  )
end

engineer_skills = []
300.times do |i|

  skill_id = rand(1..31)
  engineer_id = rand(1..100)

  while engineer_skills.include?([skill_id,engineer_id])
    skill_id = rand(1..31)
    engineer_id = rand(1..100)
  end

  engineer_skills.push([skill_id,engineer_id])

  EngineerSkill.create(
    :skill_id             => skill_id,
    :engineer_id          => engineer_id,
    :years_of_experience  => rand(1..3),
    :level                => rand(1..3)
  )

end

SKILLS = ['C++','VC++','Java','JavaScript','PHP','C言語','Python','Ruby','SQL','Go言語','C#','Perl','JSON','XML',
          'Objective-C','Scala','VB.NET','Shell','Apex','COBOL','Lua','PL/SQL','XAML','Transact-SQL','C#.NET',
          'VB','CSS','HTML5','ActionScript','Postscript','CoffeeScript']

SKILLS.each do |skill|
  Skill.create( :name => skill )
end

def create_company
  Company.create(
    :name           => 'NOWALL',
    :email                  => 'nowall@nowall.co.jp',
    :password               => 'hogehoge',
    :password_confirmation  => 'hogehoge',
    :phone_number           => '090987654321',
    :url                    => 'http://nowall.co.jp',
    :representative_person  => '柳澤直',
    :status                 => 1,
    :address                => '東京都新宿区西新宿 6-15-1 セントラルパークタワー ラ・トゥール新宿 6階'
  )
end


def create_message type,engineer_id,company_id
  Message.create(
    :message_type => type,
    :engineer_id  => engineer_id,
    :company_id   => company_id,
    :title        => "タイトル文",
    :desc         => "
    テストメッセージテストメッセージ
    テストメッセージテストメッセージ
    テストメッセージテストメッセージ
    テストメッセージテストメッセージ
    info:engineer_id:#{engineer_id} company_id:#{company_id} type:#{type}
    "
  )
end

create_message(0,1,1)

#message from engineer
#3000.times do
#  create_message(0,rand(100) + 1,rand(10) + 1)
#end
#
##message from company
#3000.times do
#  create_message(1,rand(100) + 1,rand(10) + 1)
#end

#company
10.times do
  create_company()
end

Job.create(:id => 1 ,:desc => '学生')
Job.create(:id => 2 ,:desc => '正社員')
Job.create(:id => 3 ,:desc => 'フリーランス')

DesireToWork.create(:id => 1 ,:desc => '仕事を必要としていない')
DesireToWork.create(:id => 2 ,:desc => '仕事を探している')
DesireToWork.create(:id => 3 ,:desc => '今すぐにでも仕事が欲しい')
