require 'csv'

task parse_csv: :environment do
  csv_content = File.read('albums_best.csv')
  csv         = CSV.parse(csv_content, :headers => false)
  csv.each do |row|
    Article.create(
      :artist          => row[0],
      :album           => row[1],
      :label           => row[2],
      :year            => row[3],
      :reviewer        => row[4],
      :review_date     => row[5],
      :score           => row[6],
      )
  end
end