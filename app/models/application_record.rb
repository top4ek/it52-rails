# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  delegate :url_helpers, to: 'Rails.application.routes'
end
