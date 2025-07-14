# == Schema Information
#
# Table name: cards
#
#  id          :bigint           not null, primary key
#  deadline    :date
#  description :text             not null
#  status      :integer          default(0), not null
#  title       :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  board_id    :bigint           not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_cards_on_board_id  (board_id)
#  index_cards_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (board_id => boards.id)
#  fk_rails_...  (user_id => users.id)
#
class Card < ApplicationRecord
  validates :title,
    presence: true,
    length: { minimum: 2, maximum: 100 },
    format: { with: /\A(?!\@)/ }
  validates :description,
    presence: true,
    length: { minimum: 5 }
  validate :deadline_cannot_be_in_the_past
  belongs_to :user
  belongs_to :board
  has_one_attached :eyecatch
  has_many :comments, dependent: :destroy
  enum :status, { waiting: 0, progress: 1, close: 2 }
  def comment_count
    comments.count
  end

  private
  def deadline_cannot_be_in_the_past
    return if deadline.blank?
    if deadline < Date.today
      errors.add(:deadline, :in_future)
    end
  end
end
