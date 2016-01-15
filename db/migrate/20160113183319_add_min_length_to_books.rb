class AddMinLengthToBooks < ActiveRecord::Migration
  def change
    add_column :books, :min_length, :integer
  end
end
