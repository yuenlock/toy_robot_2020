# frozen_string_literal: true

module Game
  class Position
    attr_reader :x, :y, :facing

    def initialize(x:, y:, facing:) # rubocop:disable Naming/MethodParameterName
      @x = x.to_i
      @y = y.to_i
      @facing = DIRECTIONS.index(facing) || facing.to_i % DIRECTIONS_SIZE # defaults to 0/NORTH
    end

    def move
      new_position(new_x: x + MOVEMENT[facing][:x], new_y: y + MOVEMENT[facing][:y])
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
      new_position(new_facing: (DIRECTIONS_SIZE + facing + turn) % DIRECTIONS_SIZE)
    end

    def new_position(new_x: x, new_y: y, new_facing: facing)
      Position.new(x: new_x, y: new_y, facing: new_facing)
    end
  end

  MOVEMENT = [{ x: 0, y: 1 }, { x: 1, y: 0 }, { x: 0, y: -1 }, { x: -1, y: 0 }].freeze
  DIRECTIONS = %w[NORTH EAST SOUTH WEST].freeze
  DIRECTIONS_SIZE = DIRECTIONS.count
end
