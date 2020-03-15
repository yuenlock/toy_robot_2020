# frozen_string_literal: true

module IOHandlers
  class GenericOutput
    def self.call(lines, filename: nil)
      file = filename ? File.open(filename, 'w+') : $stdout

      lines.each { |line| file.write line + "\n" }

      file.close
    end
  end
end
