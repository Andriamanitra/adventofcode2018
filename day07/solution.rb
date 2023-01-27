require_relative '../lib/base.rb'

class Step
  attr_reader :name

  def initialize(name)
    @name = name
    @depends_on = []
    @finished = false
  end

  def finish!
    @finished = true
    self
  end

  def finished?
    @finished
  end

  def can_begin?
    !finished? && @depends_on.all?(&:finished?)
  end

  def add_dependency(dep)
    @depends_on << dep
    self
  end
end


class Worker
  attr_reader :working_on, :available_at

  def initialize
    @working_on = nil
    @available_at = 0
  end

  def finish_work!
    @working_on.finish! unless @working_on.nil?
    @working_on = nil
  end

  def work_on(task, finish_time)
    @working_on = task
    @available_at = finish_time
  end
end

class Day07 < AdventOfCode
  def self.take_input(s)
    steps = Hash.new
    s.scan(/Step (.) must be finished before step (.) can begin/) do |a, b|
      steps[a] ||= []
      steps[b] ||= []
      steps[b] << a
    end
    steps.freeze
  end

  def self.make_steps(input)
    steps_h = input.keys.map{ [_1, Step.new(_1)] }.to_h
    input.each do |name, deps|
      deps.each do |dep|
        steps_h[name].add_dependency(steps_h[dep])
      end
    end
    steps_h.values
  end

  part(1) do |input|
    remaining_steps = make_steps(input)

    result = ''
    available = remaining_steps.select(&:can_begin?)
    until available.empty?
      step = available.min_by(&:name)
      step.finish!
      result += step.name
      remaining_steps.delete(step)
      available = remaining_steps.select(&:can_begin?)
    end
    result
  end

  part(2) do |input|
    steps = make_steps(input)
    is_example = steps.size == 6
    num_workers = is_example ? 2 : 5
    time_per_task = is_example ? 1 : 61

    workers = Array.new(num_workers) { Worker.new }

    t = 0
    until steps.all?(&:finished?)
      available_workers = []
      workers.each do |worker|
        if worker.available_at <= t
          worker.finish_work!
          available_workers.push(worker)
        end
      end
      available_tasks = steps.select(&:can_begin?).sort_by(&:name)

      until available_tasks.empty? || available_workers.empty?
        task = available_tasks.shift
        steps.delete(task)
        worker = available_workers.shift
        finish_time = t + time_per_task + task.name.ord - 'A'.ord
        worker.work_on(task, finish_time)
      end

      t += 1
    end
    workers.map(&:available_at).max
  end
end

Day07.run
