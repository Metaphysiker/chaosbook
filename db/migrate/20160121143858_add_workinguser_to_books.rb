class AddWorkinguserToBooks < ActiveRecord::Migration
  def change
    add_column :books, :workinguser, :integer
  end
end
