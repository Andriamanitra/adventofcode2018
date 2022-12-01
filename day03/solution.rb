require_relative '../lib/base.rb'

class Day03 < AdventOfCode
  def self.take_input(s)
    s.lines.map { _1.scan(/\d+/).map(&:to_i) }
  end

  part(1) do |input|
    canvas = Hash.new(0)
    input.each do |id, x0, y0, w, h|
      (y0...y0 + h).each do |y|
        (x0...x0 + w).each do |x|
          pos = x + y * 1i
          canvas[pos] += 1
        end
      end
    end
    canvas.values.count { _1 > 1 }
  end

  part(2) do |input|
    canvas = Hash.new
    nonoverlapping = Set[]

    input.each do |id, x0, y0, w, h|
      nonoverlapping.add(id)
      (y0...y0 + h).each do |y|
        (x0...x0 + w).each do |x|
          pos = x + y * 1i
          if claimant = canvas[pos]
            nonoverlapping.delete?(claimant)
            nonoverlapping.delete?(id)
          else
            canvas[pos] = id
          end
        end
      end
    end

    if nonoverlapping.size != 1
      raise 'Expected only one nonoverlapping claim'
    end

    nonoverlapping.first
  end
end

Day03.run
