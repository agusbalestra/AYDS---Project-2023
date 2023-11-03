# frozen_string_literal: true

class LevelController < Sinatra::Application
  before do
    @user = User.find_by(id: session[:user_id])
  end

  get '/level/:id_level' do
    level = Level.find_by(id: params[:id_level])
    questions_level = Question.where(levels_id: level.id)
    question = questions_level.first

    redirect "/level/#{params[:id_level]}/question/#{question.id}"
  end

  get '/level/:id_level/question/:id_question' do
    level = Level.find_by(id: params[:id_level])
    question = Question.find_by(id: params[:id_question])

    if question.present?
      if level.id == question.levels_id
        answers = Answer.where(question_id: question.id)

        if level.id < 1000
          erb :question, locals: { level: level, question: question, answers: answers, user: @user }
        elsif @user.current_level >= 3
          erb :frontera, locals: { level: level, question: question, answers: answers, user: @user }
        else
          redirect '/menu'
        end

      else
        redirect '/menu'
      end

    else
      redirect '/menu'
    end
  end
end
