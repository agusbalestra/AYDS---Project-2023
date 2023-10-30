# frozen_string_literal: true

require 'active_record'

class Answer < ActiveRecord::Base
  belongs_to :question
  validates :text, presence: true
  validates :question, presence: true, uniqueness: true
end
