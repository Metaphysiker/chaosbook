class AddUserIdToChapters < ActiveRecord::Migration
  def change
    add_column :chapters, :user_id, :integer
  end
end
