# frozen_string_literal: true

require 'award'

def update_quality(awards)
  Array(awards).each(&:update_quality)
end
