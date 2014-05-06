
class String
  def camelize
    self[0] = self[0].upcase
    self.gsub( /_./ ) { |s|
      s[1].upcase
    }
  end
end

