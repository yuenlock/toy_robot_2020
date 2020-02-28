# frozen_string_literal: true

module Game
  MOVEMENT = [{ x: 0, y: 1 }, { x: 1, y: 0 }, { x: 0, y: -1 }, { x: -1, y: 0 }].freeze
  DIRECTIONS = %w[NORTH EAST SOUTH WEST].freeze
  DIRECTIONS_SIZE = DIRECTIONS.count

  class Position
    attr_reader :x, :y, :facing

    # x and y:
    #   - integer value of param if param is a number
    #   - value of the first numeric characters of the param if param is a string
    #   - 0 if param is a string starting with a non-digit
    #
    # facing
    #   - a uppercase string matching the 4 main compass directions
    #   - a number (including -ve), which will be adjusted to the 4 directions
    #   - an unknown string or negative defaults to 0 if for a unrecognised value
    def initialize(x:, y:, facing:) # rubocop:disable Naming/MethodParameterName
      @x = x.to_i
      @y = y.to_i
      @facing = DIRECTIONS.index(facing) || facing.to_i % DIRECTIONS_SIZE
    end

    def move
      new_x = x + MOVEMENT[facing][:x]
      new_y = y + MOVEMENT[facing][:y]

      new_position(new_x: new_x, new_y: new_y)
    end

    def left
      rotate(-1)
    end

    def right
      rotate(1)
    end

    def report
      "#{x},#{y},#{DIRECTIONS[facing]}"
    end

    private

    def rotate(turn)
      new_facing = (facing + turn) % DIRECTIONS_SIZE

      new_position(new_facing: new_facing)
    end

    def new_position(new_x: x, new_y: y, new_facing: facing)
      Position.new(x: new_x, y: new_y, facing: new_facing)
    end
  end
end
