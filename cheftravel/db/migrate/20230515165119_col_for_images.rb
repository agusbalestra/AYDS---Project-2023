class ColForImages < ActiveRecord::Migration[7.0]
  def change
    add_column :questions, :link_imagen, :string
  end
end
