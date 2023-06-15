# spec/models/user_spec.rb
require 'sinatra/activerecord'
require_relative '../../models/init.rb'

describe User do
  it "is valid with a username and email" do
    user = User.new(name: "Juan", email: "riquelme10@gmail.com", password: "seremosmenosmalosquelosdemas")
    expect(user).to be_valid
  end

  it "is invalid without a username" do
    user = User.new(email: "romi10@gmail.com", password: "boca123")
    expect(user).not_to be_valid
  end

  it "is invalid without an email address" do
    user = User.new(name: "marten", password: "bocaaa")
    expect(user).not_to be_valid
  end

  it "is invalid without an password" do
    user = User.new(name: "liomessi10", email: "soydeboca@gmail.com")
    expect(user).not_to be_valid
  end

  it "is invalid with a duplicate email address" do
    existing_user = User.create(name: "pichonadvincula", email: "peru@example.com", password: "zambradios")
    user = User.new(name: "cheftravel", email: "peru@example.com", password: "latercera")
    expect(user).not_to be_valid
  end

  it "is invalid with a duplicate username" do
    existing_user = User.create(name: "MarcosRED", email: "bocaelmasgrande@example.com", password: "matafuegos123")
    user = User.new(name: "MarcosRED", email: "tefuistealab@mail.com", password: "password")
    expect(user).not_to be_valid
  end
end