class AddPlaceToChapters < ActiveRecord::Migration
  def change
    add_column :chapters, :place, :integer
  end
end
