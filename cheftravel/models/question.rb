require 'active_record'

class Question < ActiveRecord::Base
  has_many :answers

  validates :text, presence: true
  validates :levels_id, presence: true, numericality: { only_integer: true, greater_than: 0 }

  validate :four_options

  private

  def four_options
    unless answers.size == 4
      errors.add(:base, "una pregunta debe tener 4 opciones")
    end
  end
end


