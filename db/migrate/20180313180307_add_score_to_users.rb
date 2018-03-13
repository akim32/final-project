class AddScoreToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :score, :integer, :default => 0
  end
end
