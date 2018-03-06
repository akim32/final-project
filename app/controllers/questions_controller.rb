class QuestionsController < ApplicationController
  def index
    @questions = Question.all

    render("question_templates/index.html.erb")
  end

  def show
    @question = Question.find(params.fetch("id_to_display"))

    render("question_templates/show.html.erb")
  end

  def new_form
    render("question_templates/new_form.html.erb")
  end

  def create_row
    @question = Question.new

    @question.question = params.fetch("question")
    @question.answer = params.fetch("answer")
    @question.answer_explanation = params.fetch("answer_explanation")
    @question.chat_room_id = params.fetch("chat_room_id")
    @question.user_id = params.fetch("user_id")

    if @question.valid?
      @question.save

      redirect_to("/questions", :notice => "Question created successfully.")
    else
      render("question_templates/new_form.html.erb")
    end
  end

  def edit_form
    @question = Question.find(params.fetch("prefill_with_id"))

    render("question_templates/edit_form.html.erb")
  end

  def update_row
    @question = Question.find(params.fetch("id_to_modify"))

    @question.question = params.fetch("question")
    @question.answer = params.fetch("answer")
    @question.answer_explanation = params.fetch("answer_explanation")
    @question.chat_room_id = params.fetch("chat_room_id")
    @question.user_id = params.fetch("user_id")

    if @question.valid?
      @question.save

      redirect_to("/questions/#{@question.id}", :notice => "Question updated successfully.")
    else
      render("question_templates/edit_form.html.erb")
    end
  end

  def destroy_row
    @question = Question.find(params.fetch("id_to_remove"))

    @question.destroy

    redirect_to("/questions", :notice => "Question deleted successfully.")
  end
end
