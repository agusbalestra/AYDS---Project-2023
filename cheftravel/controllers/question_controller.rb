# frozen_string_literal: true

class QuestionController < Sinatra::Application
  before do
    @user = User.find_by(id: session[:user_id])
  end

  post '/question' do
    question = Question.find(params[:question_id])
    option_id = params[:option_id].to_i

    if params[:timeout] == 'true'
      redirect "/level/#{question.levels_id}/question/#{question.id + 1}"

    elsif option_id.zero? # si el usuario no seleciona una respuesta

      redirect "/level/#{question.levels_id}/question/#{question.id}"

    else # si el usuario selecciona una respuesta

      selected_option = Answer.find(option_id)

      # Para que no sume puntos si ya contesto esa pregunta
      unless CorrectQuestions.exists?(question_id: question.id, user_id: @user.id)
        CorrectQuestions.create(question_id: question.id, user_id: @user.id)
        @user.points_treatment(selected_option.correct, question.difficulty)
      end

      correct = selected_option.correct ? 'correct' : 'incorrect'
      redirect "/#{correct}?question=#{question.id}"
    end
  end

  get '/correct' do
    question_id = params[:question]

    question = Question.find(question_id)

    erb :result, locals: { result_message: '¡CORRECTO!',
                           user: @user,
                           id_question: question.id,
                           id_level: question.levels_id,
                           informed_text: question.informed_text }
  end

  get '/incorrect' do
    question_id = params[:question]

    question = Question.find(question_id)

    erb :result, locals: { result_message: '¡INCORRECTO!',
                           id_question: question.id,
                           id_level: question.levels_id,
                           user: @user,
                           informed_text: question.informed_text,
                           correct_answer: question.answers.find_by(correct: true) }
  end
end
