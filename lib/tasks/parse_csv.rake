require 'csv'

task parse_csv: :environment do
  csv_content = File.read('albums_best.csv')
  csv         = CSV.parse(csv_content, :headers => false)
  csv.each do |row|
    artist        = Artist.where(:name => row[0]).first_or_create
    score         = Score.where(:number => row[6]).first_or_create
    album         = Album.where(:score_id => score.id, :title => row[1]).first_or_create
    Article.create(
      :artist_id       => artist.id,
      :album_id        => album.id,
      :label           => row[2],
      :year            => row[3],
      :reviewer        => row[4],
      :review_date     => row[5],
      )
  end
end