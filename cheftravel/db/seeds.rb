# Seed data for questions and answers
Answer.destroy_all
Question.destroy_all
User.destroy_all

question1 = Question.create(text: "¿Cuál es el ingrediente principal de una empanada argentina?", difficulty: 1, link_imagen: "https://github.com/eabalestra/AYDS-Project-2023/blob/main/cheftravel/public/for_questions/emapanada.png?raw=true")
Answer.create(text: "Queso", correct: false, question: question1)
Answer.create(text: "Verduras", correct: false, question: question1)
Answer.create(text: "Carne", correct: true, question: question1)
Answer.create(text: "Pollo", correct: false, question: question1)

question2 = Question.create(text: "¿Qué ingrediente no puede faltar en un asado argentino?", difficulty: 1, link_imagen: "https://raw.githubusercontent.com/eabalestra/AYDS-Project-2023/main/cheftravel/public/for_questions/messiasado.jpg")
Answer.create(text: "Pollo", correct: false, question: question2)
Answer.create(text: "Carne", correct: true, question: question2)
Answer.create(text: "Pescado", correct: false, question: question2)
Answer.create(text: "Verduras", correct: false, question: question2)

question3 = Question.create(text: "¿Cuál es el plato típico de la gastronomía argentina?", difficulty: 2, link_imagen: "https://raw.githubusercontent.com/eabalestra/AYDS-Project-2023/main/cheftravel/public/for_questions/comida_argentina.jpg")
Answer.create(text: "Milanesa", correct: false, question: question3)
Answer.create(text: "Empanadas", correct: false, question: question3)
Answer.create(text: "Ñoquis", correct: false, question: question3)
Answer.create(text: "Asado", correct: true, question: question3)

question4 = Question.create(text: "¿Qué bebida es típica de la Argentina?", difficulty: 2, link_imagen: "https://raw.githubusercontent.com/eabalestra/AYDS-Project-2023/main/cheftravel/public/for_questions/scalonichampagne.jpg")
Answer.create(text: "Coca-cola", correct: false, question: question4)
Answer.create(text: "Cerveza", correct: false, question: question4)
Answer.create(text: "Mate", correct: true, question: question4)
Answer.create(text: "Vino", correct: false, question: question4)

question5 = Question.create(text: "¿Cuál es el postre típico argentino?", difficulty: 3, link_imagen: "https://raw.githubusercontent.com/eabalestra/AYDS-Project-2023/main/cheftravel/public/for_questions/postres.jpg")
Answer.create(text: "Dulce de leche", correct: true, question: question5)
Answer.create(text: "Flan", correct: false, question: question5)
Answer.create(text: "Torta Rogel", correct: false, question: question5)
Answer.create(text: "Chocotorta", correct: false, question: question5)

question6 = Question.create(text: "¿En qué región de Argentina se consume más la pizza?", difficulty: 3, link_imagen: "https://raw.githubusercontent.com/eabalestra/AYDS-Project-2023/main/cheftravel/public/for_questions/pizza.jpeg")
Answer.create(text: "Mendoza", correct: false, question: question6)
Answer.create(text: "Buenos Aires", correct: true, question: question6)
Answer.create(text: "Córdoba", correct: false, question: question6)
Answer.create(text: "Salta", correct: false, question: question6)

question7 = Question.create(text: "¿Cual es el ingrediente principal de la milanesa a caballo?", difficulty: 2, link_imagen: "https://raw.githubusercontent.com/eabalestra/AYDS-Project-2023/main/cheftravel/public/for_questions/milanga.jpg")
Answer.create(text: "Tomate", correct: false, question: question7)
Answer.create(text: "Jamon", correct: false, question: question7)
Answer.create(text: "Huevo", correct: true, question: question7)
Answer.create(text: "Queso", correct: false, question: question7)