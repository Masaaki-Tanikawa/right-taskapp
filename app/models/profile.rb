# == Schema Information
#
# Table name: profiles
#
#  id         :bigint           not null, primary key
#  nickname   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_profiles_on_user_id  (user_id)
#
class Profile < ApplicationRecord
  belongs_to :user
  has_one_attached :avatar
  validates :nickname, presence: true
end
