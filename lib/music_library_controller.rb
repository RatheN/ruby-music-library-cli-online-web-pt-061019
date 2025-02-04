class MusicLibraryController

  def initialize(path = "./db/mp3s")
    music_importer = MusicImporter.new(path)
    music_importer.import
  end

  def call
    input = nil
    until input == "exit"
      puts "Welcome to your music library!"
      puts "To list all of your songs, enter 'list songs'."
      puts "To list all of the artists in your library, enter 'list artists'."
      puts "To list all of the genres in your library, enter 'list genres'."
      puts "To list all of the songs by a particular artist, enter 'list artist'."
      puts "To list all of the songs of a particular genre, enter 'list genre'."
      puts "To play a song, enter 'play song'."
      puts "To quit, type 'exit'."
      puts "What would you like to do?"


      input = gets.strip

      list_songs if input == "list songs"
      list_artists if input == "list artists"
      list_genres if input == "list genres"
      list_songs_by_artist if input == "list artist"
      list_songs_by_genre if input == "list genre"
      play_song if input == "play song"
    end
  end

  def list_songs
    Song.all.sort {|a, b| a.name <=> b.name}.each.with_index(1) {|s, index| puts "#{index}. #{s.artist.name} - #{s.name} - #{s.genre.name}"}
  end

  def list_artists
    Artist.all.sort {|a, b| a.name <=> b.name}.each.with_index(1) {|a, index| puts "#{index}. #{a.name}"}
  end

  def list_genres
    Genre.all.sort {|a, b| a.name <=> b.name}.each.with_index(1) {|g, index| puts "#{index}. #{g.name}"}
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    input = gets.strip

    if artist = Artist.find_by_name(input)
      artist.songs.sort {|a, b| a.name <=> b.name}.each.with_index(1) {|s, index| puts "#{index}. #{s.name} - #{s.genre.name}"}
    else
      nil
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    input = gets.strip

    if genre = Genre.find_by_name(input)
      genre.songs.sort {|a, b| a.name <=> b.name}.each.with_index(1) {|s, index| puts "#{index}. #{s.artist.name} - #{s.name}"}
    else
      nil
    end
  end

  def play_song
    puts "Which song number would you like to play?"
    input = gets.strip.to_i

    if input.between?(1,Song.all.length)
      song = Song.all.sort {|a, b| a.name <=> b.name}[input - 1]
      puts "Playing #{song.name} by #{song.artist.name}"
    else
      nil
    end
  end
end
