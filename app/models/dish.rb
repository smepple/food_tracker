# == Schema Information
#
# Table name: dishes
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  name        :string(255)
#  description :text
#  eat_date    :date
#  prep_time   :integer
#  category_id :integer
#  source_id   :integer
#  source_page :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  photo_url   :string(255)
#

class Dish < ActiveRecord::Base
  attr_accessible :category_id, :description, :eat_date, :name, 
                  :prep_time, :source_id, :source_page, :user_id,
                  :category_name, :source_name, :photo_url

  belongs_to :user
  belongs_to :category
  belongs_to :source
  has_many :comments, dependent: :destroy

  default_scope order "eat_date DESC"

  validates_presence_of :user_id, :name, :eat_date, :prep_time,
                        :category_id, :source_id, :category_name,
                        :source_name

  validates_length_of :name, maximum: MAX_DISH_NAME_LENGTH
  validates_length_of :description, maximum: MAX_DISH_DESCRIPTION_LENGTH

  validates_numericality_of :prep_time, greater_than_or_equal_to: MIN_DISH_PREP_TIME
  validates_numericality_of :source_page, greater_than_or_equal_to: MIN_DISH_SOURCE_PAGE,
                            allow_nil: true

  validates :eat_date, date: { before: Date.tomorrow, message: "can't be in the future" }

  def category_name
    name = category.try(:name)
    name.capitalize if category
  end

  def category_name=(name)
    self.category = Category.find_or_create_by_name(name) if name.present?
  end

  def source_name
    name = source.try(:name)
    name.capitalize if source
  end

  def source_name=(name)
    self.source = Source.find_or_create_by_name(name) if name.present?
  end

  def dish_name
    self.name.capitalize
  end
end
