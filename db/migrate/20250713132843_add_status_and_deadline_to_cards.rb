class AddStatusAndDeadlineToCards < ActiveRecord::Migration[8.0]
  def change
    add_column :cards, :status, :integer, default: 0, null: false
    add_column :cards, :deadline, :date
  end
end
