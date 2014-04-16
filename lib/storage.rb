class Storage
  def self.save key, value
    @@hash = {}
    @@hash[key] = value
  end

  def self.retrieve key
    @@hash[key]
  end
end