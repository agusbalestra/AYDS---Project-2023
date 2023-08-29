require 'sinatra/activerecord'
require_relative '../../models/init.rb'

describe Answer do
  
  it "answer ref to one question" do
    question = Question.new(id: 1, text: "Cual es el manjar tipico de Argentina?", difficulty: 1)
    question2 = Question.new(id: 2, text: "¿Cual es el punto del asado?",difficulty: 2)
    answer = Answer.new(text: "Dulce De Leche", correct: true, question_id: question.id)
    expect(answer.question_id). to eq(question.id)
    expect(answer.question_id). not_to eq(question2.id)
  end

  it "answer have a question" do
    answer = Answer.new(text: "Dulce De Leche", correct: true)
    expect(answer). not_to be_valid
  end

end