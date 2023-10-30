# frozen_string_literal: true

class CreateAnswers < ActiveRecord::Migration[7.0]
  create_table :answers do |t|
    t.string :text
    t.boolean :correct, default: false

    t.timestamps
  end
end
