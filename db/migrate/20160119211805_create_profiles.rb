class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.text :about
      t.text :interests
      t.text :cv
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
