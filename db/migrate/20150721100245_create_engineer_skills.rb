class CreateEngineerSkills < ActiveRecord::Migration
  def change
    create_table :engineer_skills do |t|
      t.integer     :skill_id             ,null: false
      t.belongs_to  :engineer             ,index: true
      t.integer     :years_of_experience  ,null: false 
      t.integer     :level                ,null: false 

      t.timestamps null: false
    end
  end
end
