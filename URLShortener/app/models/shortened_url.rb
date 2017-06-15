# == Schema Information
#
# Table name: shortened_urls
#
#  id         :integer          not null, primary key
#  long_url   :string           not null
#  short_url  :string           not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ShortenedUrl < ApplicationRecord
  validates :user_id, presence: true
  validates :short_url, presence: true
  validates :long_url, presence: true
  validates :short_url, uniqueness: true


  has_one :submitter,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :ShortenedUrl

  has_many :visits,
    primary_key: :id,
    foreign_key: :shortened_url_id,
    class_name: :Visit

  has_many :visitors,
    through: :visits,
    source: :user


  def self.random_code
    url = SecureRandom.urlsafe_base64(6)
    while ShortenedUrl.exists?(short_url: url)
      url = SecureRandom.urlsafe_base64(6)
    end
    url
  end



  def self.generate_url(long, user_id)
    random = random_code
    ShortenedUrl.create!(user_id: user_id, short_url: random, long_url: long)
  end

  def num_clicks
    visits.count
  end

  def uniques
    visits.select(:user_id).distinct.count
  end

  def recent_uniques
    visits.select { |v| v.created_at > 1.day.ago }
  end
end
