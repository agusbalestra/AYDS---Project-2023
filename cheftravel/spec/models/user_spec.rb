# frozen_string_literal: true

# spec/models/user_spec.rb
require 'sinatra/activerecord'
require_relative '../../models/init'

describe User do
  it 'is a valid user' do
    user = User.new(name: 'romanino', email: 'riquelme10torero@gmail.com', password: 'avostegusta?')
    user.reppw = 'avostegusta?'
    expect(user).to be_valid
  end

  it 'is invalid without a username' do
    user = User.new(email: 'romi10@gmail.com', password: 'boca123')
    user.reppw = 'boca123'
    expect(user).not_to be_valid
  end

  it 'is invalid without an email' do
    user = User.new(name: 'marten', password: 'bocaaa')
    user.reppw = 'bocaaa'
    expect(user).not_to be_valid
  end

  it 'is invalid without a password' do
    user = User.new(name: 'liomessi10', email: 'soydeboca@gmail.com')
    expect(user).not_to be_valid
  end

  it 'is invalid with a duplicate email address' do
    existing_user = User.create(name: 'pichonadvincula', email: 'peru@example.com', password: 'zambradios')
    user = User.new(name: 'cheftravel', email: 'peru@example.com', password: 'latercera')
    expect(user).not_to be_valid
    existing_user.destroy
  end

  it 'is invalid with a duplicate username' do
    existing_user = User.create(name: 'MarcosRED', email: 'bocaelmasgrande@example.com', password: 'matafuegos123')
    user = User.new(name: 'MarcosRED', email: 'tefuistealab@mail.com', password: 'password')
    expect(user).not_to be_valid
    existing_user.destroy
  end

  it 'is valid if pws matches' do
    user = User.new(name: 'marquitos', email: 'tefuistealab@gmail.com', password: 'paswor')
    user.reppw = 'paswor'
    expect(user).to be_valid
  end

  it 'is invalid with a email without @' do
    user = User.new(name: 'koka', email: 'mail.com', password: 'password')
    expect(user).not_to be_valid
  end

  # TESTS for points tratament
  it 'updates points with a question of difficulty 1' do
    user = User.new(name: 'colo', email: 'colobarco@gmail.com', password: 'aguanteboca123')
    user.reppw = 'aguanteboca123'
    question = double('¿Cual es el manjar tipico de Argentina?', difficulty: 1)
    user.sum_points(question)
    expect(user.points).to eq(10)
  end

  it 'updates points with a question of difficulty 2' do
    user = User.new(name: 'lucasjanson', email: 'jansonson@mail.com', password: 'bocaaaaa12')
    user.reppw = 'bocaaaaa12'
    question = double('¿Qué tipo de madera es tradicionalmente utilizada para el fuego del asado?', difficulty: 2)
    user.points = 100
    user.sum_points(question)
    expect(user.points).to eq(120)
  end

  it 'updates points with a question of difficulty 3' do
    user = User.new(name: 'Carlos', email: 'apache@mail.com', password: 'bocaaaaa12')
    user.reppw = 'bocaaaaa12'
    question = double('¿Qué rol cumple la vainilla en su preparación?', difficulty: 3)
    user.sum_points(question)
    expect(user.points).to eq(30)
  end

  it 'updates points negatively with a question of difficulty 1' do
    user = User.new(name: 'hamburguesitafabra', email: 'ffabra@example.com', password: 'liberenAlPanitaVilla123')
    user.reppw = 'liberenAlPanitaVilla123'
    question = double('¿Cuáles son los ingredientes para preparar dulce de leche?', difficulty: 1)
    user.rest_points(question)
    expect(user.points).to eq(-10)
  end

  it 'updates points negatively with a question of difficulty 2' do
    user = User.new(name: 'javiGODcia', email: 'javmanco1@mail.com', password: 'aBreyLeFaltaTodavia123')
    user.reppw = 'aBreyLeFaltaTodavia123'
    question = double('¿Cuál es el proceso principal para lograr un buen asado argentino?', difficulty: 2)
    user.rest_points(question)
    expect(user.points).to eq(-20)
  end

  it 'updates points negatively with a question of difficulty 3' do
    user = User.new(name: 'Roncaglia', email: 'troncaglia2@mail.com', password: 'oPasaLaPelotaoPasaElJugador')
    user.reppw = 'oPasaLaPelotaoPasaElJugador'
    user.points = 100
    question = double('¿Por qué el Dulce de Leche se debe revolver constantemente durante su preparación?',
                      difficulty: 3)
    user.rest_points(question)
    expect(user.points).to eq(100 - 30)
  end
end
