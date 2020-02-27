# frozen_string_literal: true

module Game
  class Play
    def self.call(commands:)
      RobotControl.call(
        commands: commands,
        robot: Robot.new(grid: Grid.new),
        position_class: Position
      )
    end
  end
end
