require 'sinatra/activerecord'
require_relative '../../models/init.rb'

describe Answer do

  it "answer have a question" do
    answer = Answer.new(text: "Dulce De Leche", correct: true)
    expect(answer.valid?). to be_falsey
  end

  it "answer valid" do
    question = Question.new(id: 1, text: "Cual es el manjar tipico de Argentina?", difficulty: 1)
    answer = Answer.new(text: "Dulce De Leche", correct: true, question: question)
    expect(answer.valid?).to be_truthy
  end
  
end
