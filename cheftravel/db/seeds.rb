# Seed some questions
#Answer = Class.new(ActiveRecord::Base)
#Answer.create(text: "Huevo", correct: true)
#Answer.create(text: "Tomate", correct: false)
#Answer.create(text: "Jamon", correct: false)
#Answer.create(text: "Queso", correct: false)


Question = Class.new(ActiveRecord::Base)
Question.create(text: "¿Cuál es el ingrediente principal de la milanesa a caballo", difficulty: 1, answer_id: 1)

