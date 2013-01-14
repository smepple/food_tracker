# == Schema Information
#
# Table name: authors
#
#  id         :integer          not null, primary key
#  firstname  :string(255)
#  lastname   :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Author < ActiveRecord::Base
  attr_accessible :firstname, :lastname

  has_many :sources, dependent: :destroy

  validates_presence_of :firstname, :lastname
end
