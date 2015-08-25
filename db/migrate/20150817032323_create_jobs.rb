class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string      :desc

      t.timestamps null: false
    end
  end
end
