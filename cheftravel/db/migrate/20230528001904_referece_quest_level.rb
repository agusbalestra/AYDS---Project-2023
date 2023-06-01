class RefereceQuestLevel < ActiveRecord::Migration[7.0]
  def change
    add_reference :questions, :levels, foreign_key: true

  end
end
