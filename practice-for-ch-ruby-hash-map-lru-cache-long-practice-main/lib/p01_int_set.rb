class MaxIntSet
  attr_reader :store
  def initialize(max)
    @max = max
    @store = Array.new(max)
  end

  def insert(num)
    
    @store[num] = true if is_valid?(num)

  end

  def remove(num)
    @store[num] = false if is_valid?(num)
  end

  def include?(num)
    return true if @store[num] == true
  end

  private

  def is_valid?(num)
    raise "Out of bounds" if num < 0 || num > @max
    return true
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

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
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
    if @count >= num_buckets
      resize!
    end
    unless include?(num)
      self[num] << num
      @count += 1
    end
  end

  def remove(num)
    if include?(num) 
      self[num].delete(num)
      @count -= 1
    end
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def num_buckets
    @store.length
  end

  def resize!
    new_store = Array.new(num_buckets * 2) { Array.new }


    @store.each do |bucket|
      bucket.each do |num|
        new_store[num % (num_buckets * 2)] << num
      end
    end

    @store = new_store
  end

  def [](num)
    @store[num % num_buckets]
  end
end