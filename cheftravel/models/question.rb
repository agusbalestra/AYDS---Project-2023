# frozen_string_literal: true

require 'active_record'
require_relative 'answer'
require_relative 'user'

# This class represents a question in the system.
# It has a text, a level of difficulty, an associated answer and a list of answers.
# It also has a list of users who have answered it correctly.
class Question < ActiveRecord::Base
  has_many :answers
  has_many :correct_questions
  has_many :users, through: :correct_questions

  validates_associated :answers

  validates :text, presence: true
  validates :levels_id, presence: true, numericality: { only_integer: true, greater_than: 0 }
  # Has a correct associated answer
  validates :answer_id, presence: true, numericality: { only_integer: true, greater_than: 0 }
end
