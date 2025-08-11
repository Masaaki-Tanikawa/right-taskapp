# frozen_string_literal: true

Kaminari.configure do |config|

  config.default_per_page = 12   # ← デフォルトを12にする
  config.max_per_page = 12       # ← それ以上は表示しない
	config.window       = 1   # 現在ページの左右2つ
  config.outer_window = 1   # 先頭と末尾は1ページ
  config.left         = 0
  config.right        = 0
  # config.page_method_name = :page
  # config.param_name = :page
  # config.max_pages = nil
  # config.params_on_first_page = false
end
