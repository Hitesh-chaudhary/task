class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :website
      t.string :short_website
      t.text :site_data
      t.timestamps
    end
  end
end
