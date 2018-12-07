require 'byebug'

class MaxIntSet
  
  def initialize(max)
    @max = max
    @store = Array.new(max, false)
  end

  def insert(num)
    raise 'Out of bounds' unless is_valid?(num)

    self.store[num] = true
  end

  def remove(num)
    raise 'Out of bounds' unless is_valid?(num)

    self.store[num] = false
  end

  def include?(num)
    self.store[num]
  end

  protected

  attr_accessor :store

  private

  attr_reader :max

  def is_valid?(num)
    0 <= num && num <= max
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num] << num
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  attr_reader :store

  def [](num)
    store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    unless self.include?(num)
      self[num] << num
      self.count += 1
    end

    if self.count == num_buckets 
      resize!
    end
  end

  def remove(num)
    if self.include?(num)
      self[num].delete(num)
      self.count -= 1
    end
  end

  def include?(num)
    self[num].include?(num)
  end

  protected

  attr_writer :count
  attr_accessor :store

  private

  def [](num)
    store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_store = ResizingIntSet.new(num_buckets * 2)

    self.store.each do |bucket|
      bucket.each do |el|
        self.remove(el)
        new_store.insert(el)
        self.count += 1
      end
    end

    self.store = new_store.store
  end
end
