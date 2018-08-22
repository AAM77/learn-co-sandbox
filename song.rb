
class Song
  attr_accessor :name, :album
  attr_reader :id
  
  
  def initialize(id = nil, name, album)
    @id = id
    @name = name
    @album = album
  end # class
  
  
  def save
    sql = <<-SQL
      INSERT INTO songs (name, album)
      VALUES (?, ?)
    SQL
    
    DB[:conn].execute(sql, self.name, self.album)
    @id = DE[:conn].execute("SELECT last_insert_rowid() FROM songs")[0][0]
  end #save
  
  
  def self.create(name:, album:)
    song = Song.new(name, album)
    song.save
    song
  end #create
  
  
  def self.find_by_name(name)
    sql = "SELECT * FROM songs WHERE name = ?"
    result = DB[:conn].execute(sql, name)[0]
    Song.new(result[0], result[1], result[2])
  end #find_by_name
  
end #class Song