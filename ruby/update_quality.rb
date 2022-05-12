# frozen_string_literal: true

require_relative './award'

def update_quality(awards)
  awards.each(&:update!)
end
