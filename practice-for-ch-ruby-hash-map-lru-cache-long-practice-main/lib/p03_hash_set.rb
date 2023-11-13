class HashSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(item)
    if @count >= num_buckets
      resize!
    end
    unless include?(item)
      self[item] << item
      @count += 1
    end
  end

  def remove(item)
    if include?(item)
      self[item].delete(item)
      @count -= 1
    end
  end

  def include?(item)
    self[item].include?(item)
  end

  private

  def num_buckets
    @store.length
  end

  def resize!
    new_store = Array.new(num_buckets * 2) { Array.new }


    @store.each do |bucket|
      bucket.each do |item|
        new_store[item.hash % (num_buckets * 2)] << item
      end
    end

    @store = new_store
  end

  def [](item)
    @store[item.hash % num_buckets]
  end
end
