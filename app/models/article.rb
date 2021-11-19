class Article < ApplicationRecord
  validates :article, presence: true
  validates :album, presence: true
  validates :label, presence: true
  validates :year, presence: true
  validates :reviewer, presence: true
  validates :review_date, presence: true
  validates :score, presence: true
end
