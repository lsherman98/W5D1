require_relative 'p04_linked_list'

class HashMap
  attr_accessor :count
  include Enumerable
  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket = bucket(key)
    bucket.each do |node|
      return true if node.key == key
    end
    return false
  end

  def set(key, val)
    bucket = bucket(key)
    if @store[bucket].include?(key)
      @store[bucket].update(key, val)
    else
      @store[bucket].append(key, val)
    end
  end

  def get(key)
    bucket = bucket(key)
    @store[bucket].get(key)
  end

  def delete(key)
    bucket = bucket(key)
    @store[bucket].remove(key)
  end

  def each
    @store.each do |bucket|
      bucket.each do |node|
        yield [node.key, node.val]
      end
    end
  end

  # uncomment when you have Enumerable included
  # def to_s
  #   pairs = inject([]) do |strs, (k, v)|
  #     strs << "#{k.to_s} => #{v.to_s}"
  #   end
  #   "{\n" + pairs.join(",\n") + "\n}"
  # end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    (key.hash) % num_buckets
  end
end
