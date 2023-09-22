class ChangeColumnPointsAddDefault < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :points, :int, default: 0
  end
end
