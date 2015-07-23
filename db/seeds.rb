# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Engineer.create(
  :id                     => 1,
  :name                   => "柳澤 直",
  :email                  => "n.yanagisawa@nowall.co.jp",
  :password               => "hogehoge",
  :password_confirmation  => "hogehoge",
  :self_introduction      => "自己紹介文なり",
  :living_place           => "湘南台",
  :age                    => 21,
  :phone_number           => '09096760070',
  :status                 => 0,
  :job_history            => '内緒だお',
  :is_invitation_enabled  => true,
)

EngineerSkill.create(
  :skill_id             => 4,
  :engineer_id          => 1, 
  :years_of_experience  => 3,
  :level                => 2
)

EngineerSkill.create(
  :skill_id             => 8,
  :engineer_id          => 1, 
  :years_of_experience  => 3,
  :level                => 2
)

EngineerSkill.create(
  :skill_id             => 4,
  :engineer_id          => 1, 
  :years_of_experience  => 3,
  :level                => 2
)

EngineerSkill.create(
  :skill_id             => 11,
  :engineer_id          => 1, 
  :years_of_experience  => 2,
  :level                => 2
)

EngineerSkill.create(
  :skill_id             => 27,
  :engineer_id          => 1, 
  :years_of_experience  => 3,
  :level                => 3
)


EngineerSkill.create(
  :skill_id             => 28,
  :engineer_id          => 1, 
  :years_of_experience  => 3,
  :level                => 3
)

SKILLS = ['C++','VC++','Java','JavaScript','PHP','C言語','Python','Ruby','SQL','Go言語','C#','Perl','JSON','XML',
          'Objective-C','Scala','VB.NET','Shell','Apex','COBOL','Lua','PL/SQL','XAML','Transact-SQL','C#.NET',
          'VB','CSS','HTML5','ActionScript','Postscript','CoffeeScript']

SKILLS.each do |skill|
  Skill.create( :name => skill )
end
