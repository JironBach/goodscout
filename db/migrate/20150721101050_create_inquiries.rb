class CreateInquiries < ActiveRecord::Migration
  def change
    create_table :inquiries do |t|
      t.string  :title                  ,null: false
      t.text    :desc                   ,null: false
      t.integer :how_to_reply           ,null: false
      t.string  :company_name           ,null: false
      t.string  :company_email          ,null: false
      t.string  :company_phone_number   ,null: false
      t.string  :representative_person  ,null: false

      t.timestamps null: false
    end
  end
end
