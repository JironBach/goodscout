# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

100.times do |i|
  Engineer.create(
    :id                     => i + 1,
    :name                   => "柳澤 直:#{i + 1}",
    :email                  => "n.yanagisawa#{i + 1}@nowall.co.jp",
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
