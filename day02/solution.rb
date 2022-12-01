require_relative '../lib/base.rb'

class Day02 < AdventOfCode
  def self.take_input(s)
    s.split
  end

  part(1) do |input|
    twos = 0
    threes = 0
    input.each do |word|
      letter_freqs = word.tally.values
      twos += 1 if letter_freqs.include?(2)
      threes += 1 if letter_freqs.include?(3)
    end
    twos * threes
  end

  part(2) do |input|
    a, b = input.combination(2).find do |a, b|
      a.zip(b).one?{_1 != _2}
    end
    a.zip(b).filter_map{_1 == _2 ? _1 : nil}.join
  end
end

Day02.run
