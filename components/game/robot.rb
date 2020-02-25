# frozen_string_literal: true

require_relative './errors.rb'

module Game
  class Robot
    attr_reader :grid, :current_position

    def initialize(grid:, position: nil)
      @grid = grid
      @current_position = position
    end

    def place(position:)
      raise InvalidPlacementError unless validate_position(position)

      update_position position
    end

    def left
      placed? && update_position(current_position.left)
    end

    def right
      placed? && update_position(current_position.right)
    end

    def move
      return unless placed?

      new_pos = current_position.move
      update_position(new_pos) if validate_position(new_pos)
    end

    def report
      current_position.report
    end

    private

    def update_position(position)
      @current_position = position
    end

    def validate_position(position)
      grid.valid_position?(position)
    end

    def placed?
      current_position || raise(InvalidPlacementError)
    end
  end
end

