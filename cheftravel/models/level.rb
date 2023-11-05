# frozen_string_literal: true

require 'active_record'

# The Level class represents a level in the ChefTravel game.
class Level < ActiveRecord::Base
  belongs_to :question
end
