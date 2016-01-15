class CreateChapters < ActiveRecord::Migration
  def change
    create_table :chapters do |t|
      t.string :chaptertitle
      t.text :chaptercontent
      t.string :author

      t.timestamps null: false
    end
  end
end
