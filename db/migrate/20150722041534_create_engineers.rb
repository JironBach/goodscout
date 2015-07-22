class CreateEngineers < ActiveRecord::Migration
  def change
    create_table :engineers do |t|
      t.string  :name                  ,null: false
      t.string  :email,null: false
      t.string  :encrypted_password    ,null: false
      t.text    :self_introduction     ,null: false
      t.string  :living__place
      t.string  :fb_uid
      t.string  :github_uid
      t.integer :age                   ,null: false
      t.integer :phone_number          ,limit: 8
      t.integer :status                ,null: false
      t.text    :job_history           ,null: false
      t.text    :notes
      t.boolean :is_invitation_enabled ,null: false

      t.timestamps null: false
    end
  end
end
