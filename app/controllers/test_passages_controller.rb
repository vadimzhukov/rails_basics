class TestPassagesController < ApplicationController
  before_action :authenticate_user!

  before_action :set_test_passage, only: %i[show update result gist]

  def show
    if @test_passage.test.questions.count == 0
      redirect_to tests_path, alert: 'Этот тест нельзя пройти, пока в нем нет вопросов'
    else
      render :show
    end
  end

  def update
    @test_passage.accept!(params[:answer_ids])

    if @test_passage.current_question
      render :show
    else
      redirect_to result_test_passage_path(@test_passage)
    end
  end

  def result; end

  private

  def set_test_passage
    @test_passage = TestPassage.find(params[:id])
  end
end
