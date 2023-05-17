require_relative '../lib/base.rb'

class NodeReader
  attr_reader :nodes

  def initialize(nums)
    @nums = nums
    @nodes = []
    @i = 0
  end

  def read
    num_children, num_metadata = @nums[@i, 2]
    @i += 2
    children = []
    num_children.times do
      children << read
    end
    metadata = []
    num_metadata.times do
      metadata << @nums[@i]
      @i += 1
    end
    node = {children: children, metadata: metadata}
    @nodes << node
    node
  end
end

class Day08 < AdventOfCode
  def self.take_input(s)
    s.split.map(&:to_i)
  end

  def self.node_value(node)
    return node[:metadata].sum if node[:children].empty?

    node[:metadata].sum do |i|
      next 0 if i < 1 || i > node[:children].size
      node_value(node[:children][i-1])
    end
  end

  part(1) do |input|
    reader = NodeReader.new(input)
    reader.read
    reader.nodes.sum { |node| node[:metadata].sum }
  end

  part(2) do |input|
    reader = NodeReader.new(input)
    root = reader.read
    node_value(root)
  end
end

Day08.run
