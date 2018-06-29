class MaxIntSet
  def initialize(max)
    @store = Array.new(max+1, false)
  end

  def insert(num)
    if is_valid?(num)
      @store[num] = true 
    else
      raise "Out of bounds"
    end
  end

  def remove(num)
    @store[num] = false if include?(num)
  end

  def include?(num)
    return @store[num] if is_valid?(num)
    false
  end

  private

  def is_valid?(num)
    num > 0 && num < @store.length
  end
  # 
  # def validate!(num)
  # 
  # end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num] << num
  end

  def remove(num)
    if self.include?(num)
      self[num].delete(num)
    end
  end

  def include?(num)
    self[num].any? {|n| num == n}
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num%20]
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
    unless include?(num)
      self[num] << num
      @count += 1
    end
    resize! if count == num_buckets 
  end

  def remove(num)
    if self.include?(num)
      self[num].delete(num)
      @count -=1
    end
    
  end

  def include?(num)
    self[num].any? {|n| num == n}
  end

  private

  def [](num)
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    old_store = @store.dup
    @store = Array.new(num_buckets * 2) { Array.new }
    @count = 0
    old_store.each_index do |idx|
      old_store[idx].each do |el|
        insert(el)
      end
    end
  end
end
