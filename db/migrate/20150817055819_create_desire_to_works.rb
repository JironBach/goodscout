class CreateDesireToWorks < ActiveRecord::Migration
  def change
    create_table :desire_to_works do |t|
      t.string      :desc

      t.timestamps null: false
    end
  end
end
