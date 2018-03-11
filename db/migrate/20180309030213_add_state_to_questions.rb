class AddStateToQuestions < ActiveRecord::Migration[5.0]
  def change
    add_column :questions, :state, :integer, :default => 0
  end
end
