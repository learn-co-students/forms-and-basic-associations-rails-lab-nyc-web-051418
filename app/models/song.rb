class Song < ActiveRecord::Base
  belongs_to :artist
  belongs_to :genre
  has_many :notes

  def genre_name=(name)
    self.genre = Genre.find_or_create_by(name: name)
    self.save
  end

  def genre_name
    self.genre ? self.genre.name : nil
  end

  def artist_name=(name)
    self.artist = Artist.find_or_create_by(name: name)
    self.save
  end

  def artist_name
    self.artist ? self.artist.name : nil
  end

  def note_contents=(list)
    list.each do |item|
      if !item.empty?
        if !Note.find_by(content: item, song: self)
          Note.create(content: item, song: self)
        end
      end
    end
    self.reload
  end

  def note_contents
    self.notes.map do |item|
      item.content
    end
  end

end
