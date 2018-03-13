class ScoresController < ApplicationController
  def index
    @scores = Score.all

    render("score_templates/index.html.erb")
  end

  def show
    @score = Score.find(params.fetch("id_to_display"))

    render("score_templates/show.html.erb")
  end

  def new_form
    render("score_templates/new_form.html.erb")
  end

  def create_row
    @score = Score.new

    @score.user_id = params.fetch("user_id")
    @score.question_id = params.fetch("question_id")

    if @score.valid?
      @score.save

      redirect_to("/scores", :notice => "Score created successfully.")
    else
      render("score_templates/new_form.html.erb")
    end
  end

  def edit_form
    @score = Score.find(params.fetch("prefill_with_id"))

    render("score_templates/edit_form.html.erb")
  end

  def update_row
    @score = Score.find(params.fetch("id_to_modify"))

    @score.user_id = params.fetch("user_id")
    @score.question_id = params.fetch("question_id")

    if @score.valid?
      @score.save

      redirect_to("/scores/#{@score.id}", :notice => "Score updated successfully.")
    else
      render("score_templates/edit_form.html.erb")
    end
  end

  def destroy_row
    @score = Score.find(params.fetch("id_to_remove"))

    @score.destroy

    redirect_to("/scores", :notice => "Score deleted successfully.")
  end
end
