class CreateInquiries < ActiveRecord::Migration
  def change
    create_table :inquiries do |t|
      t.string  :title        ,null: false
      t.text    :desc         ,null: false
      t.integer :how_to_reply ,null: false
      t.integer :company_id   ,null: false

      t.timestamps null: false
    end
  end
end
