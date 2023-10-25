# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 20_231_010_153_125) do
  create_table 'answers', force: :cascade do |t|
    t.string 'text'
    t.boolean 'correct', default: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'question_id'
    t.index ['question_id'], name: 'index_answers_on_question_id'
  end

  create_table 'correct_questions', force: :cascade do |t|
    t.integer 'user_id'
    t.integer 'question_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['question_id'], name: 'index_correct_questions_on_question_id'
    t.index ['user_id'], name: 'index_correct_questions_on_user_id'
  end

  create_table 'levels', force: :cascade do |t|
    t.string 'name'
    t.string 'text'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'questions', force: :cascade do |t|
    t.string 'text'
    t.integer 'difficulty'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'link_imagen'
    t.integer 'levels_id'
    t.string 'informed_text'
    t.index ['levels_id'], name: 'index_questions_on_levels_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'name'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'password'
    t.string 'firstname'
    t.string 'lastname'
    t.string 'email'
    t.integer 'points', default: 0
    t.integer 'current_level', default: 0
    t.string 'password_digest'
  end

  add_foreign_key 'answers', 'questions'
  add_foreign_key 'correct_questions', 'questions'
  add_foreign_key 'correct_questions', 'users'
  add_foreign_key 'questions', 'levels', column: 'levels_id'
end
