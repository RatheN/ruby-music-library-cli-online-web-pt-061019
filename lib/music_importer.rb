class MusicImporter
  attr_accessor :path

  def initialize(path)
    @path = path
  end

  def files
    Dir.entries(path).select{|f| f.end_with?(".mp3")}
  end

  def import
    files.each do |f|
      Song.create_from_filename(f)
    end
  end
end
