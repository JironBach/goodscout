class CreateSkills < ActiveRecord::Migration
  def change
    create_table :skills do |t|
      t.string :name , null: false, unique: false

      t.timestamps null: false
    end
  end
end
