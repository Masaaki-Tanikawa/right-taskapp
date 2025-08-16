class MakeUserIdNotNullOnComments < ActiveRecord::Migration[8.0]
  def change
    change_column_null :comments, :user_id, false
  end
end
