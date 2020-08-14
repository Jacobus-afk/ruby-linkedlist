# frozen_string_literal: true

# https://commandercoriander.net/blog/2012/12/23/reversing-a-linked-list-in-ruby/

# ruby implementation of linked list
class LinkedList
  include Enumerable

  attr_reader :head, :tail

  def initialize
    @head = nil
    @tail = nil
  end

  def append(value)
    node = Node.new(value)
    @tail.next_node = node unless @head.nil?
    @tail = node
    @head = node if @head.nil?
  end

  def prepend(value)
    node = Node.new(value)
    node.next_node = @head unless @head.nil?
    @head = node
    @tail = node if @head.nil?
  end

  def size
    size = 0
    each_with_index { |_, _| size += 1 }
    size
  end

  def at(search_index)
    each_with_index do |entry, index|
      return entry if index == search_index
    end
  end

  def pop
    prev_node = nil
    each_with_index do |entry, _|
      if entry.next_node.nil?
        @tail = prev_node
        @tail.next_node = nil
      end
      prev_node = entry
    end
  end

  def contains?(value)
    return true if find(value)

    false
  end

  def find(value)
    each_with_index { |entry, index| return index if entry.value == value }
  end

  def to_s
    tmp_str = ''
    each_with_index do |entry, _|
      tmp_str += '( ' + entry.value + ' ) -> ' unless entry.nil?
    end
    tmp_str += 'nil'
  end

  private

  def each_with_index
    index = 0
    return nil, index if @head.nil?

    entry = @head
    until entry.nil?
      yield entry, index
      entry = entry.next_node
      index += 1
    end
  end
end

# node class
class Node
  attr_accessor :value, :next_node
  def initialize(value = nil)
    @value = value
    @next_node = nil
  end
end

test = LinkedList.new

test.append('a')
test.prepend('b')
test.append('c')
test.append('d')

puts test.head.value
puts test.tail.value
puts test.size
puts test.at(1).value

puts test
test.pop
puts test.tail.value
puts test

puts test.contains?('a')
puts test.contains?('f')

puts test.find('a')
