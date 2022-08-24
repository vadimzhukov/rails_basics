class QuestionsController < ApplicationController
  before_action :find_test, only: %i[index new create]
  before_action :find_question, only: %i[show edit update destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :question_not_found

  def index; end

  def show; end

  def new
    @question = Question.new
  end

  def create
    new_question = @test.questions.build(question_parameters)

    if new_question.save
      redirect_to test_questions_path(@test)
    else
      render :new
    end
  end

  def edit; end

  def update
    if @question.update(question_parameters)
      redirect_to @question
    else
      render :edit
    end
  end

  def destroy
    if @question.destroy
      redirect_to test_questions_path(@question.test)
    else
      render plain: "При удалении вопроса возникла ошибка"
    end
  end

  private

  def find_test
    @test = Test.find(params[:test_id])
  end

  def find_question
    @question = Question.find(params[:id])
  end

  def question_parameters
    params.require(:question).permit(:body, :test_id)
  end

  def question_not_found
    render plain: "Вопрос с id #{params[:id]} не найден"
  end
end
