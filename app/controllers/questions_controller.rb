# TODO: Add validation for the existence of tag as well as title length (mentioned elsewhere)

class QuestionsController < ApplicationController
  respond_to :json
  before_filter :ensure_logged_in, only: [:new, :create]

  def show
    #@question = Question.eager_load([:tags, :answers]).find(params[:id])
    @question = Question.find(params[:id])
    respond_with @question
  end

  def new
    @tags = Tag.all.map do |tag|
      tag.name
    end

    render :new
  end

  def create
    question = Question.new(params[:question])
    question.user_id = self.current_user.id

    tags = params[:question_tags]
    tags = format_tags(tags)

    found_tags = {}
    Tag.where(name: tags).select([:id, :name]).each{ |x| found_tags[ "_#{x.id}" ] = x.name }

    tag_ids = []

    tags.each do |tag|
      if found_tags.values.include? tag
       tag_ids << found_tags.key(tag)[1..-1]

      else
        new_tag = Tag.create({name: tag })
        tag_ids << new_tag.id
      end
    end

    question.tag_ids = tag_ids

    if question.save
      #redirect_to question_url(question.id)
      respond_with question
      # TODO: Json add tags and user
    else
      flash.now[:notice] = question.errors.full_messages
     # render :new
     respond_with false
    end

  end

  def index
    @questions = Question.page(params[:page]).per(30)
    respond_with @questions
  end



end
