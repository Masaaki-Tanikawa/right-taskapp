# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# db/seeds.rb
require 'faker'

Faker::Config.locale = :ja

# ---- ユーザー作成 ----
users = User.all
if users.empty?
  puts "ユーザーが存在しないため、ダミーユーザーを作成します..."
  users = 10.times.map do
    User.create!(
      email: Faker::Internet.unique.email,
      password: 'password',
      password_confirmation: 'password'
    )
  end
end

# ---- ステータス候補（日本語）----
statuses = %w[未着手 進行中 完了]

# ---- Board作成 ----
boards = []
100.times do
  boards << Board.create!(
    title: Faker::Lorem.words(number: 3).join(' '),
    description: Faker::Lorem.paragraph(sentence_count: 3),
    user_id: users.sample.id,
    created_at: Faker::Time.between(from: 1.year.ago, to: Time.now),
    updated_at: Time.now
  )
end

statuses =
  if Card.respond_to?(:statuses) && Card.statuses.is_a?(Hash)
    Card.statuses.keys             # => ["todo", "in_progress", "done"]
  else
    %w[todo in_progress done]      # フォールバック
end
# ---- 1番目のBoardにCardを100件作成 ----
first_board = boards.first

100.times do
  created_at = Faker::Time.between(from: first_board.created_at, to: Time.now)

  Card.create!(
    title: Faker::Lorem.words(number: rand(2..5)).join(' '),
    description: Faker::Lorem.paragraph(sentence_count: 2),
    status: statuses.sample,  # ← 日本語ではなく enum キーを渡す
    deadline: [nil, Faker::Date.forward(days: rand(1..90))].sample,
    board_id: first_board.id,
    user_id: users.sample.id,
    created_at: created_at,
    updated_at: created_at
  )
end