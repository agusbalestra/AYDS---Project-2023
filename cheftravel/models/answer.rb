# frozen_string_literal: true

require 'active_record'

# The Answer class represents an answer to a question in the ChefTravel application.
class Answer < ActiveRecord::Base
  belongs_to :question
  validates :text, presence: true
  validates :question, presence: true, uniqueness: true
end
