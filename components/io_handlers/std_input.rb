# frozen_string_literal: true

require 'English'

module IOHandlers
  class StdInput
    def self.call(_)
      commands = []
      commands << $LAST_READ_LINE while STDIN.gets != "DONE\n"
      commands
    end
  end
end
