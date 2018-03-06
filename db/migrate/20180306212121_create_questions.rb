class CreateQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :questions do |t|
      t.string :question
      t.string :answer
      t.string :answer_explanation
      t.references :user, foreign_key: true
      t.references :chat_room, foreign_key: true
      
      t.timestamps
    end
  end
end
