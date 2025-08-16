class MakeUserIdNotNullOnCards < ActiveRecord::Migration[8.0]
  def change
    change_column_null :cards, :user_id, false
  end
end
