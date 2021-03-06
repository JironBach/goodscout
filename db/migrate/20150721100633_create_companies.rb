class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string  :name                   ,null: false
      t.string  :email                  ,null: false
      t.string  :password_digest
      t.string  :phone_number
      t.string  :url
      t.string  :image
      t.string  :representative_person  ,null: false
      t.string  :encryped_password
      t.integer :status                 ,null: false
      t.string  :address

      t.timestamps null: false
    end
  end
end
