# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  email      :string
#

class User < ActiveRecord::Base
  validates :email, presence: true
  validates :email, uniqueness: true


  has_many :submitted_urls,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :ShortenedUrl


  has_many :visits,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :Visit

  has_many :visited_urls,
    through: :visits,
    source: :shortened_url


end
