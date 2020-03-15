#!/usr/bin/env ruby

# frozen_string_literal: true

require './components/game.rb'
require './components/io_handlers.rb'

class RobotCLI
  class << self
    def call(filename:)
      robot = Game::Robot.new(grid: Game::Grid.new)

      IOHandlers::LargeFileInput.call(filename: filename) do |commands|
        output Game::Play.call(commands: commands, robot: robot)
      end
    rescue StandardError => e
      output [e.message]
    end

    private

    def output(result)
      IOHandlers::ScreenOutput.call result
    end
  end
end

RobotCLI.call(filename: ARGV.first)
