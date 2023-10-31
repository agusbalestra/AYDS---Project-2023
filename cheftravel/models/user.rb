# frozen_string_literal: true

require_relative 'question'
require_relative 'correct_questions'

class User < ActiveRecord::Base
  has_secure_password

  has_many :correct_questions
  has_many :questions, through: :correct_questions

  validates :name, presence: true, uniqueness: true, length: { in: 3..30 }

  # Verifica que haya un caracter antes y dsp del @
  validates :email,
            presence: true,
            uniqueness: true,
            format: { with: /\A[^@\s]+@[^@\s]+\z/, message: 'debe ser una dirección de correo electrónico válida' }

  after_initialize :set_default_points

  attr_accessor :reppw, :auth_with_google

  def set_default_points
    self.points ||= 0
  end

  def points_treatment(correct, diff)
    if correct
      sum_points(diff)
      level_treatment
    else
      rest_points(diff)
    end
  end

  def sum_points(diff)
    new_points = self.points
    case diff
    when 1
      new_points += 10
    when 2
      new_points += 20
    when 3
      new_points += 30
    end
    update_attribute :points, new_points
  end

  def rest_points(diff)
    new_points = self.points
    case diff
    when 1
      new_points -= 10
    when 2
      new_points -= 20
    when 3
      new_points -= 30
    end
    update_attribute :points, new_points
  end

  def level_treatment
    Level.all.each do |level|
      questions_for_level = Question.where(levels_id: level.id)
      if questions_for_level.all? { |q| CorrectQuestions.exists?(question_id: q.id, user_id: id) }
        update_attribute :current_level, level.id
      end
    end
  end

  # END OF MODEL
end
