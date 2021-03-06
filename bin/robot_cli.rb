#!/usr/bin/env ruby

# frozen_string_literal: true

require './components/game.rb'
require './components/io_handlers.rb'

class RobotCLI
  def self.call(filename:)
    commands = IOHandlers::FileInput.call(filename: filename)

    IOHandlers::ScreenOutput.show Game::Play.call(commands: commands)
  rescue StandardError => e
    IOHandlers::ScreenOutput.show [e.message]
  end
end

RobotCLI.call(filename: ARGV.first)
