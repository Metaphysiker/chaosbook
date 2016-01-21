class AddFristToBooks < ActiveRecord::Migration
  def change
    add_column :books, :frist, :datetime
  end
end
