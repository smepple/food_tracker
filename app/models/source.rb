# == Schema Information
#
# Table name: sources
#
#  id         :integer          not null, primary key
#  author_id  :integer
#  name       :string(255)
#  url        :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Source < ActiveRecord::Base
  attr_accessible :author_id, :name, :url

  belongs_to :author
  has_many :dishes

  validates_presence_of :name
  validates_length_of :name, in: MIN_SOURCE_NAME_LENGTH..MAX_SOURCE_NAME_LENGTH
  validates_format_of :url, with: VALID_URL_REGEX, allow_nil: true
end
