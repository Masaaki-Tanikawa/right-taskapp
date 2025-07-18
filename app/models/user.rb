# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # パスワードの最低文字数を6文字から4文字に変更
  validates :password, length: { minimum: 4 }, if: :password_required?


  has_many :boards, dependent: :destroy
	has_many :cards, dependent: :destroy
	has_many :comments, dependent: :destroy
	has_one :profile, dependent: :destroy

	def display_name
    profile&.nickname || self.email.split('@').first
	end
	def prepare_profile
    profile || build_profile
  end
  def avatar_image
    if profile&.avatar&.attached?
      profile.avatar
    else
      'default-avatar.png'
    end
  end

end
