class AddTimerToTests < ActiveRecord::Migration[6.1]
  def change
    add_column :tests, :timer, :decimal
  end
end
