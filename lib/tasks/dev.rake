namespace :dev do
  desc "Hydrate the database with some dummy data to make it easier to develop"
  task :prime => :environment do
      Question.destroy_all
      Question.create!([
        {id: 1, question: "3*1?", answer: "3", answer_explanation: "Exp goes here", user_id: 1, chat_room_id: 4, created_at: "2015-08-12 17:20:05", updated_at: "2015-08-12 17:20:05"},
        {id: 2, question: "What is the capital of Illinois?", answer: "Springfield", answer_explanation: "duh", user_id: 1, chat_room_id: 4, created_at: "2015-08-12 17:20:05", updated_at: "2015-08-12 17:20:05"},
        {id: 3, question: "Type asd?", answer: "asd", answer_explanation: "", user_id: 1, chat_room_id: 4, created_at: "2015-08-12 17:20:05", updated_at: "2015-08-12 17:20:05"},
        ])

    puts "There are now #{Question.count} questions in the database."
    
  end
end
