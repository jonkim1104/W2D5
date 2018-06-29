class HashSet
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
    @store[(num.hash) % num_buckets]
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
