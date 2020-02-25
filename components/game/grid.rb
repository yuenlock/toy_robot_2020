# frozen_string_literal: true

module Game
  class Grid
    attr_reader :max_x, :max_y

    def initialize(size_x:, size_y:)
      @max_x = size_x - 1
      @max_y = size_y - 1
    end

    def valid_position?(position)
      position.x.between?(0, max_x) && position.y.between?(0, max_y)
    end
  end
end
