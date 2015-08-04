class CreateMessages < ActiveRecord::Migration

  def change

    create_table :messages do |t|
      t.integer     :message_type      ,null: false
      t.references  :engineer
      t.references  :company
      t.string      :title     ,null: false
      t.text        :desc      ,null: false

      t.timestamps null: false
    end

    add_index :messages, :engineer_id
    
  end

end
