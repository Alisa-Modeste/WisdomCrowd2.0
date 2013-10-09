# TODO: Get the tags in the right format
# TODO: Add validation for the existence of tag as well as title length (mentioned elsewhere)

class QuestionsController < ApplicationController
  def show
    @question = Question.find(params[:id])
    render :show
  end

  def new
    render :new
  end

  def create
    question = Question.new(params[:question])
    question.user_id = self.current_user.id

    if question.save
      redirect_to question_url(question.id)
    else
      flash.now[:notice] = question.errors.full_messages
      render :new
    end

  end

  def index
    @questions = Question.page(params[:page]).per(10)
    p "here", @questions
    p params
    #render :index
    render "index"
  end

  def search
    search = params[:search]
    Question.search_database(nil, search)
  end
end
