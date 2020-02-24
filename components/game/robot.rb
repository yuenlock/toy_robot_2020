# frozen_string_literal: true

module Game
  class Robot
    attr_reader :grid, :current_position

    def initialize(grid:, position: nil)
      @grid = grid
      @current_position = position
    end

    def place(position:)
      update_position(position)
    end

    def left
      update_position(current_position.left)
    end

    def right
      update_position(current_position.right)
    end

    private

    def update_position(position)
      @current_position = position if validate_position(position, InvalidPlacementError)
    end

    def validate_position(position, error_class = InvalidMoveError)
      grid.valid_position?(position) || raise(error_class)
    end

    def placed?
      current_position || raise(InvalidPlacementError)
    end
  end
end

class InvalidPlacementError < StandardError
end

class InvalidMoveError < StandardError
end
