class ChangeDefaultLevel < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :current_level, :int, default: 0
  end
end
