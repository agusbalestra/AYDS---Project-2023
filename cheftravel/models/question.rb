# frozen_string_literal: true

require 'active_record'
require_relative 'answer'
require_relative 'user'

class Question < ActiveRecord::Base
  has_many :answers
  has_many :correct_questions
  has_many :users, through: :correct_questions

  validates_associated :answers

  validates :text, presence: true
  validates :levels_id, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :answer_id, presence: true, numericality: { only_integer: true, greater_than: 0 } # has a correct associated answer
end
