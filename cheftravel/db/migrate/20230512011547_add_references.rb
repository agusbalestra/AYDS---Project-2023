class AddReferences < ActiveRecord::Migration[7.0]
  def change
    add_reference :questions, :answer, foreign_key: true
  end
end
