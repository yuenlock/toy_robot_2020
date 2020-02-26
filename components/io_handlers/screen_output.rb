# frozen_string_literal: true

module IOHandlers
  class ScreenOutput
    def self.show(lines)
      puts

      lines.each { |line| puts line }

      puts
    end
  end
end
