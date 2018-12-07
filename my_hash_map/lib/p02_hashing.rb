class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    return 1090890832908902 if self.empty?
    
    self.reduce { |acc, ele| ele.hash }
  end
end

class String
  def hash
    char_codepoints = []
    
    self.each_codepoint do |code_point|
      char_codepoints << code_point
    end

    char_codepoints.reduce do |acc, el|
      (acc ^ el) * 10338
    end
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    self.to_a.sort.hash.hash
  end
end
