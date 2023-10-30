# frozen_string_literal: true

require 'active_record'

class Level < ActiveRecord::Base
  belongs_to :question
end
