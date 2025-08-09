# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  content    :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  card_id    :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_comments_on_card_id  (card_id)
#  index_comments_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (card_id => cards.id)
#  fk_rails_...  (user_id => users.id)
#
class Comment < ApplicationRecord
	belongs_to :user
	belongs_to :card
  validates :content, presence: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[id content created_at updated_at]
  end
end
