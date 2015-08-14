class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :notification_type  , null: false
      t.integer :user_type          , null: false
      t.integer :user_id            , null: false
      t.boolean :is_done            , null: false , default: false

      t.timestamps null: false
    end
  end
end
