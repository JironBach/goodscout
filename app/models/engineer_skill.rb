class EngineerSkill < ActiveRecord::Base

  belongs_to :engineer

  def self.insert_engineer_skills skills
    skills.uniq!
    skills.each { |skill| skills.delete(skill) if EngineerSkill.where(skill).length > 0 }
    EngineerSkill.create(skills)
  end

  def self.get_engineer_ids_by_skill search_condition

    engineer_skills = EngineerSkill.where([
      "skill_id = ? and years_of_experience >= ? and level >= ?",
      search_condition['skill_id'],
      search_condition['years_of_experience'],
      search_condition['level'],
    ])

    if engineer_skills.length > 0
      ids = []
      engineer_skills.each do |e|
        ids.push(e.engineer_id)
      end
      return ids
    else
      return nil
    end

  end

end
