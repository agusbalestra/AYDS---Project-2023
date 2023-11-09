# frozen_string_literal: true

class AddPointsUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :points, :int
  end
end
