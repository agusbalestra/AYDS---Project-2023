# frozen_string_literal: true

require_relative 'question'
require_relative 'correct_questions'

# This class represents a user in the system.
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

  # Sets the default value for the user's points.
  def set_default_points
    self.points ||= 0
  end

  # Updates the user's points based on the correctness of the answer and the difficulty of the question.
  def points_treatment(correct, diff)
    if correct
      sum_points(diff)
      level_treatment
    else
      rest_points(diff)
    end
  end

  # Adds points to the user's total points.
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

  # Subtracts points from the user's total points.
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

  # Updates the user's current level based on the correctness of all the questions in each level.
  def level_treatment
    Level.all.each do |level|
      questions_for_level = Question.where(levels_id: level.id)
      if questions_for_level.all? { |q| CorrectQuestions.exists?(question_id: q.id, user_id: id) }
        update_attribute :current_level, level.id
      end
    end
  end
end
