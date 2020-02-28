# frozen_string_literal: true

require_relative './errors.rb'

module Game
  class Robot
    attr_reader :grid, :current_position

    def initialize(grid:, position: nil)
      @grid = grid
      @current_position = position
    end

    def place(params)
      raise InvalidPlacementError unless validate_position(params[:position])

      update_position params[:position]
    end

    def left(_params = nil)
      placed? && update_position(current_position.left)
    end

    def right(_params = nil)
      placed? && update_position(current_position.right)
    end

    def move(_params = nil)
      new_pos = placed? && current_position.move

      validate_position(new_pos) && update_position(new_pos)
    end

    def report(_params = nil)
      placed? && current_position.report
    end

    private

    def update_position(position)
      @current_position = position
      nil
    end

    def validate_position(position)
      grid.valid_position?(position)
    end

    def placed?
      current_position || raise(InvalidPlacementError)
    end
  end
end
