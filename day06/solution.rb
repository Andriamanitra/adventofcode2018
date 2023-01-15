require_relative '../lib/base.rb'

class Day06 < AdventOfCode
  def self.take_input(s)
    s.each_line(chomp: true)
     .map { _1.split(', ').map(&:to_i) }
  end

  part(1) do |coords|
    xs, ys = coords.transpose
    xmin, xmax = xs.minmax
    ymin, ymax = ys.minmax
    area_size = Hash.new(0)
    (xmin..xmax).each do |x|
      (ymin..ymax).each do |y|
        closest_dist = 2**31
        closest_beacon = nil

        coords.each do |cx, cy|
          dist = (x - cx).abs + (y - cy).abs
          if dist < closest_dist
            closest_dist = dist
            closest_beacon = [cx, cy]
          elsif dist == closest_dist
            # ties should not be counted
            closest_beacon = nil
          end
        end

        next if closest_beacon.nil?
        if x == xmin || x == xmax || y == ymin || y == ymax
          area_size[closest_beacon] = Float::INFINITY
        else
          area_size[closest_beacon] += 1
        end
      end
    end

    area_size.values.reject(&:infinite?).max
  end

  part(2) do |coords|
    # example has different max_dist
    max_dist = coords.size == 6 ? 32 : 10_000
    xs, ys = coords.transpose
    x = xs.minmax.sum / 2
    y = ys.minmax.sum / 2
    # flood fill starting from the center
    q = [[x, y]]
    visited = Set[[x, y]]
    num_safe_locations = 0
    until q.empty?
      x, y = q.shift
      if coords.sum{|cx, cy| (x - cx).abs + (y - cy).abs} < max_dist
        num_safe_locations += 1
        q << [x+1, y] if visited.add?([x+1, y])
        q << [x-1, y] if visited.add?([x-1, y])
        q << [x, y+1] if visited.add?([x, y+1])
        q << [x, y-1] if visited.add?([x, y-1])
      end
    end
    num_safe_locations
  end
end

Day06.run
