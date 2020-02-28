# frozen_string_literal: true

module Game
  MOVEMENT = [{ x: 0, y: 1 }, { x: 1, y: 0 }, { x: 0, y: -1 }, { x: -1, y: 0 }].freeze
  DIRECTIONS = %w[NORTH EAST SOUTH WEST].freeze
  DIRECTIONS_SIZE = DIRECTIONS.count

  class Position
    attr_reader :x, :y, :facing

    def initialize(x:, y:, facing:) # rubocop:disable Naming/MethodParameterName
      @x = x.to_i
      @y = y.to_i
      @facing = DIRECTIONS.index(facing) || facing.to_i % DIRECTIONS_SIZE # defaults to 0/NORTH
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
      new_facing = (DIRECTIONS_SIZE + facing + turn) % DIRECTIONS_SIZE

      new_position(new_facing: new_facing)
    end

    def new_position(new_x: x, new_y: y, new_facing: facing)
      Position.new(x: new_x, y: new_y, facing: new_facing)
    end
  end
end
