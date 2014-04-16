class Storage
  def self.save key, value
    storage = PStore.new("storage.pstore")
    storage.transaction do 
      storage[key.to_sym] = value
    end
  end

  def self.retrieve key
    storage = PStore.new("storage.pstore")
    storage.transaction { storage[key.to_sym] }
  end
end