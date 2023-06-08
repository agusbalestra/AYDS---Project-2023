Answer.destroy_all
Question.destroy_all
Level.destroy_all
Level.create(name:"Dulce de Leche", text:"Ingredientes:\n- 1 litro de leche entera\n- 250 g de azúcar \n- 1 cucharadita de bicarbonato de sodio\n- Esencia de vainilla\n
  Necesitaras:\n- Una olla\n- Cuchara de madera\n- Recipiente para guardar el dulce\nPasos a seguir:\n
  1. Introduce en la olla la leche y caliéntala a fuego medio hasta que hierva.\n
  2. Cuando hierva, baja un poco el fuego y añade el azúcar. Con una cuchara de madera remueve bien para evitar que se queme o se pegue en la base.\n 
  Debes mezclar hasta que el azúcar esté bien disuelto para hacer el dulce de leche.\n
  3. Cuando el azúcar se haya disuelto, añade el bicarbonato de sodio y la esencia de vainilla.\n
  La vainilla es al gusto pero te recomendamos que no viertas más de un cucharadita, para evitar que el sabor a dulce de leche disminuya.\n
  4. Sigue removiendo el dulce de leche sin dejar que hierva. Poco a poco verás que el color va cambiando hasta alcanzar el tono marrón tan característico de este postre.\n
  5. Conseguir la textura y color ideal del dulce de leche puede llevarte alrededor de 2 horas. Una vez hecho, guárdalo en un frasco y ya puedes comerlo como más te guste, en tostadas, crepes, tartas, etc.")

Question.create(text:"¿Cuál es el manjar tipico de Argentina?", difficulty: 1, link_imagen: "https://media.istockphoto.com/id/1398880959/es/foto/s%C3%ADmbolo-de-signo-de-interrogaci%C3%B3n-para-preguntas-frecuentes-informaci%C3%B3n-problemas-y-conceptos.webp?b=1&s=170667a&w=0&k=20&c=dMaP3PbKWnVSVzNI5Um5LS9bfoTMD058sEPRkQ_6-EM=", levels_id: 1, informed_text: "El dulce de leche, es un producto lácteo, que generalmente se utiliza como cobertura de postres tipicos de Argentina")
Answer.create(text: "Arequipe", correct: false, question_id: 1)
Answer.create(text: "Nutella", correct: false, question_id: 1)
Answer.create(text: "Dulce de Leche", correct: true, question_id: 1)
Answer.create(text: "Chocolate", correct: false, question_id: 1)

Question.create(text: "¿Cuáles son los ingredientes para preparar dulce de leche?", difficulty: 1, link_imagen: "https://www.cucinare.tv/wp-content/uploads/2019/10/Dulce-de-leche.jpg", levels_id: 1, informed_text: "El dulce de leche es leche concentrada azucarada.")
Answer.create(text: "Leche, crema, nuez", correct: false, question_id: 2)
Answer.create(text: "Agua, leche, avellana", correct: false, question_id: 2)
Answer.create(text: "Caramelo, leche, vainilla", correct: false, question_id: 2)
Answer.create(text: "Leche, azucar, vainilla", correct: true, question_id: 2)

Question.create(text: "¿Cuál es el tiempo estimado para hacer dulce de leche?", difficulty: 1, link_imagen: "https://previews.123rf.com/images/kongvector/kongvector1801/kongvector180101987/93077357-chef-del-reloj-de-alarma-de-dibujos-animados-del-car%C3%A1cter.jpg", levels_id: 1, informed_text: "Conseguir la textura y color ideal del dulce de leche puede llevarte alrededor de 2 horas")
Answer.create(text: "Menos de 1/2 hora", correct: false, question_id: 3)
Answer.create(text: "Al menos 2 horas", correct: true, question_id: 3)
Answer.create(text: "1 hora, aproximadamente", correct: false, question_id: 3)
Answer.create(text: "Alrededor de 5 horas", correct: false, question_id: 3)

Question.create(text: "¿Cuál es la cantidad de bicarbonato de sodio recomendado?", difficulty: 1, link_imagen: "https://www.cucinare.tv/wp-content/uploads/2019/10/Dulce-de-leche.jpg", levels_id: 1)
Answer.create(text: "No lleva", correct: false, question_id: 4)
Answer.create(text: "100 gr", correct: false, question_id: 4)
Answer.create(text: "1 cucharadita", correct: true, question_id: 4)
Answer.create(text: "1/2 kg", correct: false, question_id: 4)

Question.create(text: "¿La preparacion se debe ir revolviendo?", difficulty: 1, link_imagen: "https://www.cucinare.tv/wp-content/uploads/2019/10/Dulce-de-leche.jpg", levels_id: 1, informed_text: "Con una cuchara de madera se debe ir removiendo bien durante toda la coccion para evitar que se queme o se pegue en la base.")
Answer.create(text: "No es necesario", correct: false, question_id: 5)
Answer.create(text: "Una vez cada media hora", correct: false, question_id: 5)
Answer.create(text: "Depende", correct: false, question_id: 5)
Answer.create(text: "Si, todo el tiempo", correct: true, question_id: 5)