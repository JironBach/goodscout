class CreateMessages < ActiveRecord::Migration

  def change

    create_table :messages do |t|
      t.integer     :message_type ,null: false
      t.references  :engineer     ,null: false
      t.references  :company      ,null: false
      t.string      :title        ,null: false
      t.text        :desc         ,null: false
      t.string      :attached_file_name
      t.binary      :attached_file
      t.boolean     :is_read      ,null: false, default: false

      t.timestamps null: false
    end

    add_index :messages, :engineer_id
    
  end

end
