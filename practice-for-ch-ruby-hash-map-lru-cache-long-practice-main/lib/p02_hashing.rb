class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    total = 0
    self.each do |el|
      total += el.to_s(2).to_i.hash
    end
  end
end

class String
  def hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    0
  end
end


p [1, 3, 2].hash
