# frozen_string_literal: true

module Game
  class InvalidPlacementError < StandardError
    def message
      'Please place the robot in a valid position within the grid.'
    end
  end
end
