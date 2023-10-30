# frozen_string_literal: true

class AlterUser < ActiveRecord::Migration[7.0]
  add_column :users, :password, :string
  add_column :users, :firstname, :string
  add_column :users, :lastname, :string
  add_column :users, :email, :string
end
