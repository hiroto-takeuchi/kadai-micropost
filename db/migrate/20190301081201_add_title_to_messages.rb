class AddTitleToMessages < ActiveRecord::Migration[5.0]
  def change
    add_column :microposts, :title, :string
  end
end
