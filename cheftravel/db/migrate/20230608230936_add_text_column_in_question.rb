# frozen_string_literal: true

class AddTextColumnInQuestion < ActiveRecord::Migration[7.0]
  def change
    add_column :questions, :informed_text, :string
  end
end
