# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  dish_id    :integer
#  user_id    :integer
#  content    :text
#  ancestry   :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Comment < ActiveRecord::Base
  attr_accessible :dish_id, :user_id, :content, :parent_id

  belongs_to :dish
  belongs_to :user

  has_ancestry

  scope :recent, order("created_at DESC")

  validates_presence_of :dish_id, :user_id, :content
  validates_length_of :content, maximum: MAX_COMMENT_CONTENT_LENGTH
end
