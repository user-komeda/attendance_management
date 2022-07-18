# frozen_string_literal: true

# Class without body
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
