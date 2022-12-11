require_relative '../lib/base.rb'

class Day05 < AdventOfCode
  def self.take_input(s)
    s.strip
  end

  part(1) do |input|
    result = []
    input.each_byte do |charcode|
      if result.last ^ 32 == charcode
        result.pop
      else
        result.push charcode
      end
    end
    result.size
  end

  part(2) do |input|
    sizes = (?A..?Z).map do |letter|
      result = []
      input.delete(letter + letter.downcase).each_byte do |charcode|
        if result.last ^ 32 == charcode
          result.pop
        else
          result.push charcode
        end
      end
      result.size
    end
    sizes.min
  end
end

Day05.run
