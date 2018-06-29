class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    answer = 0
    self.each_with_index do |el,i|
      el = el.hash if el.is_a?(Array) || el.is_a?(String)
      el = 0 if el.nil? 
      answer = answer^(el * i)
    end
      answer.hash
  end
end

class String
  def hash
    return self.ord.hash if self.length == 1
    self.split("").hash
  end
  
  def ascii
    ans = self.each_byte.reduce(:^)
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    batter = self.map do |k,v|
      if k.is_a?(String)
        k = k.ascii
        [k,v]
      else [k,v]
      end
    end
    arr = batter.sort_by {|k,v| k}
    arr.hash
  end
end
