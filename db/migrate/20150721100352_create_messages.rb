class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :from_type ,null: false
      t.integer :from_id   ,null: false
      t.integer :to_id     ,null: false
      t.string  :title     ,null: false
      t.text    :desc      ,null: false

      t.timestamps null: false
    end
  end
end
