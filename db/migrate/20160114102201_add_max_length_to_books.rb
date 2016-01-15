class AddMaxLengthToBooks < ActiveRecord::Migration
  def change
    add_column :books, :max_length, :integer
  end
end
