# frozen_string_literal: true

class AddCorrectQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :correct_questions do |t|
      t.references :user, foreign_key: true
      t.references :question, foreign_key: true
      t.timestamps
    end
  end
end
