require_relative '../lib/base.rb'

class Day04 < AdventOfCode
  def self.take_input(s)
    s.lines(chomp: true).map{|line|
      y, m, d, hh, mm = line.scan(/\d+/).map(&:to_i)
      timestamp = Time.new(y, m, d, hh, mm)
      [timestamp, line.split('] ')[1]]
    }.sort
  end

  part(1) do |input|
    time_asleep = Hash.new(0)
    guard = nil
    t = nil
    input.each do |timestamp, note|
      if note.start_with?('Guard')
        guard = note.split[1]
      elsif note == 'wakes up'
        seconds_slept = (timestamp - t).to_i
        time_asleep[guard] += seconds_slept
      elsif note == 'falls asleep'
        t = timestamp
      else
        warn "unhandled note: '#{note}'"
      end
    end
    guard_id, _ = time_asleep.max_by{_2}
    guard = nil
    start_mm = nil
    end_mm = nil
    slept_minutes = [0] * 60
    input.each do |timestamp, note|
      if note.start_with?('Guard')
        guard = note.split[1]
      elsif guard == guard_id
        if note == 'falls asleep'
          start_mm = timestamp.min
        elsif note == 'wakes up'
          end_mm = timestamp.min
          (start_mm...end_mm).each{slept_minutes[_1] += 1}
        end
      end
    end
    _, minute = slept_minutes.each_with_index.max_by{|count, minute| count}
    guard_id[1..].to_i * minute
  end

  part(2) do |input|
    guard_minutes = Hash.new{|h,k| h[k] = [0] * 60}
    guard = nil
    start_mm = nil
    input.each do |timestamp, note|
      if note.start_with?('Guard')
        guard = note.split[1]
      elsif note == 'wakes up'
        end_mm = timestamp.min
        (start_mm...end_mm).each do |i|
          guard_minutes[guard][i] += 1
        end
      elsif note == 'falls asleep'
        start_mm = timestamp.min
      end
    end
    guard_id, minutes = guard_minutes.max_by{_2.max}
    _, minute = minutes.each_with_index.max_by{|count, minute| count}
    guard_id[1..].to_i * minute
  end
end

Day04.run
