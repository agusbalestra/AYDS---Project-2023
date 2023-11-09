# frozen_string_literal: true

require 'sinatra/activerecord'
require_relative '../../models/init'

describe Question do
  it 'is a valid question' do
    question = Question.new(text: 'Estas leyendo?', levels_id: 1, answer_id: 2)
    expect(question).to be_valid
  end

  it 'is invalid with no text' do
    question = Question.new(levels_id: 1, answer_id: 2)
    expect(question).not_to be_valid
  end

  it 'is invalid with no correct answer associated' do
    question = Question.new(text: 'Que te parece?', levels_id: 1)
    expect(question).not_to be_valid
  end

  it 'is invalid with negative id of answer associated' do
    question = Question.new(text: 'Seguis leyendo?', levels_id: 1, answer_id: -2)
    expect(question).not_to be_valid
  end
end
