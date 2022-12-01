require_relative '../lib/base.rb'

class Day01 < AdventOfCode
  def self.take_input(s)
    s.lines.map(&:to_i)
  end

  part(1) do |input|
    input.sum
  end

  part(2) do |input|
    freq = 0
    seen = Set[freq]
    input.cycle do |change|
      freq += change
      break if seen.add?(freq).nil?
    end
    freq
  end
end

Day01.run
