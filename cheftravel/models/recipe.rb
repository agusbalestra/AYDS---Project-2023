# frozen_string_literal: true

require 'active_record'

class Recipe < ActiveRecord::Base
  has_many :user
end
