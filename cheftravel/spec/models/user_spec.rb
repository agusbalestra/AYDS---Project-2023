# spec/models/user_spec.rb
require 'sinatra/activerecord'
require_relative '../../models/init.rb'

describe User do

  it "is a valid user" do
    user = User.new(name: "romanino", email: "riquelme10torero@gmail.com", password: "avostegusta?")
    user.reppw = "avostegusta?"
    expect(user).to be_valid
  end

  it "is invalid without a username" do
    user = User.new(email: "romi10@gmail.com", password: "boca123")
    user.reppw = "boca123"
    expect(user).not_to be_valid
  end

  it "is invalid without an email" do
    user = User.new(name: "marten", password: "bocaaa")
    user.reppw = "bocaaa"
    expect(user).not_to be_valid
  end

  it "is invalid without a password" do
    user = User.new(name: "liomessi10", email: "soydeboca@gmail.com")
    expect(user).not_to be_valid
  end

  it "is invalid with a duplicate email address" do
    existing_user = User.create(name: "pichonadvincula", email: "peru@example.com", password: "zambradios")
    user = User.new(name: "cheftravel", email: "peru@example.com", password: "latercera")
    expect(user).not_to be_valid
    existing_user.destroy
  end

  it "is invalid with a duplicate username" do
    existing_user = User.create(name: "MarcosRED", email: "bocaelmasgrande@example.com", password: "matafuegos123")
    user = User.new(name: "MarcosRED", email: "tefuistealab@mail.com", password: "password")
    expect(user).not_to be_valid
    existing_user.destroy
  end

  it "is invalid if pws not matches" do
    user = User.new(name: "MarcosRED", email: "tefuistealab@mail.com", password: "password", reppw: "paswor")
    expect(user).not_to be_valid
  end

  it "is valid if pws matches" do
    user = User.new(name: "marquitos", email: "tefuistealab@gmail.com", password: "paswor")
    user.reppw = "paswor"
    expect(user).to be_valid
  end
  
  it "is invalid with a email without @" do
    user = User.new(name: "koka", email: "mail.com", password: "password")
    expect(user).not_to be_valid
  end

  it "is invalid with a too short pw" do
    user = User.new(name: "changuito", email: "elchango7eballos@hotmail.com", password: "aaa")
    user.reppw = "aaa"
    expect(user).not_to be_valid
  end

end