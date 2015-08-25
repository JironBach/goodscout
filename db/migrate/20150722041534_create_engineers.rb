class CreateEngineers < ActiveRecord::Migration
  def change

    create_table :engineers do |t|
      t.string      :name                  ,null: false
      t.string      :email                 ,null: false
      t.string      :image
      t.string      :password_digest       ,null: false
      t.text        :self_introduction     ,null: false
      t.string      :living_place
      t.string      :fb_uid
      t.string      :fb_url
      t.string      :github_uid
      t.string      :github_url
      t.integer     :age                   ,null: false
      t.string      :phone_number
      t.text        :job_history           ,null: false
      t.references  :job                   ,null: false
      t.references  :desire_to_work        ,null: false
      t.text        :notes
      t.boolean     :is_invitation_enabled ,null: false , default: true

      t.timestamps null: false
    end

  end
end
