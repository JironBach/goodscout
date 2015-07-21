class CreateEnginners < ActiveRecord::Migration
  def change
    create_table :enginners do |t|
      t.string  :name                     ,null:  false
      t.string  :email                    ,null:  false
      t.string  :picture
      t.string  :encrypted_password       ,null:  false
      t.text    :self_introduction        ,null:  false
      t.string  :living_place
      t.string  :fb_uid
      t.string  :github_uid
      t.integer :age                      ,null:  false
      t.integer :phone_number             ,limit: 8
      t.integer :status                   ,null:  false ,default: 0
      t.text    :job_history              ,null:  false
      t.text    :notes
      t.boolean :is_registration_enabled  ,null:  false ,default: 0

      t.timestamps null: false
    end
  end
end
