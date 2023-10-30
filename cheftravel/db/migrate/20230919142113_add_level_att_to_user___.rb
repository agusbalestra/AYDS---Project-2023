# frozen_string_literal: true

class AddLevelAttToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :current_level, :int, default: 1
  end
end
