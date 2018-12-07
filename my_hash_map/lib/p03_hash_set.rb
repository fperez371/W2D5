class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    unless self.include?(key)
      self[key.hash] << key
      self.count += 1
    end

    if self.count == num_buckets
      resize!
    end
  end

  def include?(key)
    self[key.hash].include?(key)
  end
  
  def remove(key)
    if self.include?(key)
      self[key.hash].delete(key)
      self.count -= 1
    end
  end
  
  protected
  
  attr_accessor :store
  attr_writer :count
  
  private
  
  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_store = HashSet.new(num_buckets * 2)

    self.store.each do |bucket|
      bucket.each do |ele|
        new_store.insert(ele)
        self.remove(ele)
        self.count += 1
      end
    end

    self.store = new_store.store
  end
end
