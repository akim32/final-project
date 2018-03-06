Rails.application.routes.draw do
  # Routes for the Question resource:

  # CREATE
  get("/questions/new", { :controller => "questions", :action => "new_form" })
  post("/create_question", { :controller => "questions", :action => "create_row" })

  # READ
  get("/questions", { :controller => "questions", :action => "index" })
  get("/questions/:id_to_display", { :controller => "questions", :action => "show" })

  # UPDATE
  get("/questions/:prefill_with_id/edit", { :controller => "questions", :action => "edit_form" })
  post("/update_question/:id_to_modify", { :controller => "questions", :action => "update_row" })

  # DELETE
  get("/delete_question/:id_to_remove", { :controller => "questions", :action => "destroy_row" })

  #------------------------------

  devise_for :users

  resources :chat_rooms, only: [:new, :create, :show, :index]

  mount ActionCable.server => '/cable'

  root 'chat_rooms#index'
end
