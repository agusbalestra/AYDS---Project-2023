# frozen_string_literal: true

require 'active_record'

# The Recipe class represents a recipe in the ChefTravel application.
class Recipe < ActiveRecord::Base
  has_many :user
end
