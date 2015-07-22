class EngineerSkill < ActiveRecord::Base

  def self.insert_engineer_skills skills
    EngineerSkill.create(skills)
  end

end
