# frozen_string_literal: true

module IOHandlers
  class ScreenOutput
    def self.call(lines)
      lines.each { |line| puts line }
    end
  end
end
