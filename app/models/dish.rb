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
#

class Dish < ActiveRecord::Base
  attr_accessible :category_id, :description, :eat_date, :name, 
                  :prep_time, :source_id, :source_page, :user_id

  belongs_to :user
  belongs_to :category
  belongs_to :source

  validates_presence_of :user_id, :name, :eat_date, :prep_time,
                        :category_id, :source_id
end
