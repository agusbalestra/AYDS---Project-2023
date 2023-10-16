User.destroy_all
# Answer.destroy_all
# Question.destroy_all
# Level.destroy_all

# #LEVEL DULCEDELECHE
# Level.create(name:"Dulce de Leche", text:"Ingredientes:\n- 1 litro de leche entera\n- 250 g de azúcar \n- 1 cucharadita de bicarbonato de sodio\n- Esencia de vainilla\n
#   Necesitaras:\n- Una olla\n- Cuchara de madera\n- Recipiente para guardar el dulce\nPasos a seguir:\n
#   1. Introduce en la olla la leche y caliéntala a fuego medio hasta que hierva.\n
#   2. Cuando hierva, baja un poco el fuego y añade el azúcar. Con una cuchara de madera remueve bien para evitar que se queme o se pegue en la base.\n 
#   Debes mezclar hasta que el azúcar esté bien disuelto para hacer el dulce de leche.\n
#   3. Cuando el azúcar se haya disuelto, añade el bicarbonato de sodio y la esencia de vainilla.\n
#   La vainilla es al gusto pero te recomendamos que no viertas más de un cucharadita, para evitar que el sabor a dulce de leche disminuya.\n
#   4. Sigue removiendo el dulce de leche sin dejar que hierva. Poco a poco verás que el color va cambiando hasta alcanzar el tono marrón tan característico de este postre.\n
#   5. Conseguir la textura y color ideal del dulce de leche puede llevarte alrededor de 2 horas. Una vez hecho, guárdalo en un frasco y ya puedes comerlo como más te guste, en tostadas, crepes, tartas, etc.")

# Question.create(text:"¿Cuál es el manjar tipico de Argentina?", difficulty: 1, link_imagen: "https://media.istockphoto.com/id/1398880959/es/foto/s%C3%ADmbolo-de-signo-de-interrogaci%C3%B3n-para-preguntas-frecuentes-informaci%C3%B3n-problemas-y-conceptos.webp?b=1&s=170667a&w=0&k=20&c=dMaP3PbKWnVSVzNI5Um5LS9bfoTMD058sEPRkQ_6-EM=", levels_id: 1, informed_text: "El dulce de leche, es un producto lácteo, que generalmente se utiliza como cobertura de postres tipicos de Argentina")
# Answer.create(text: "Arequipe", correct: false, question_id: 1)
# Answer.create(text: "Nutella", correct: false, question_id: 1)
# Answer.create(text: "Dulce de Leche", correct: true, question_id: 1)
# Answer.create(text: "Chocolate", correct: false, question_id: 1)

# Question.create(text: "¿Cuáles son los ingredientes para preparar dulce de leche?", difficulty: 1, link_imagen: "https://www.cucinare.tv/wp-content/uploads/2019/10/Dulce-de-leche.jpg", levels_id: 1, informed_text: "La vainilla podemos usarla en forma de extracto, esencia o semillas, lo que tengamos, en la cantidad deseada para dar un poco de aroma.")
# Answer.create(text: "Leche, crema, nuez", correct: false, question_id: 2)
# Answer.create(text: "Agua, leche, avellana", correct: false, question_id: 2)
# Answer.create(text: "Caramelo, leche, vainilla", correct: false, question_id: 2)
# Answer.create(text: "Leche, azucar, vainilla", correct: true, question_id: 2)

# Question.create(text: "¿Cuál es el tiempo estimado para hacer dulce de leche?", difficulty: 1, link_imagen: "https://previews.123rf.com/images/kongvector/kongvector1801/kongvector180101987/93077357-chef-del-reloj-de-alarma-de-dibujos-animados-del-car%C3%A1cter.jpg", levels_id: 1, informed_text: "Conseguir la textura y color ideal del dulce de leche puede llevarte alrededor de 2 horas")
# Answer.create(text: "Menos de 1/2 hora", correct: false, question_id: 3)
# Answer.create(text: "Al menos 2 horas", correct: true, question_id: 3)
# Answer.create(text: "1 hora, aproximadamente", correct: false, question_id: 3)
# Answer.create(text: "Alrededor de 5 horas", correct: false, question_id: 3)

# Question.create(text: "¿Cuál es la cantidad de bicarbonato de sodio recomendado?", difficulty: 1, link_imagen: "https://www.cucinare.tv/wp-content/uploads/2019/10/Dulce-de-leche.jpg", levels_id: 1)
# Answer.create(text: "No lleva", correct: false, question_id: 4)
# Answer.create(text: "100 gr", correct: false, question_id: 4)
# Answer.create(text: "1 cucharadita", correct: true, question_id: 4)
# Answer.create(text: "1/2 kg", correct: false, question_id: 4)

# Question.create(text: "¿La preparación debe ir revolviendose?", difficulty: 1, link_imagen: "https://www.cucinare.tv/wp-content/uploads/2019/10/Dulce-de-leche.jpg", levels_id: 1, informed_text: "Con una cuchara de madera se debe ir removiendo bien durante toda la coccion para evitar que se queme o se pegue en la base.")
# Answer.create(text: "No es necesario", correct: false, question_id: 5)
# Answer.create(text: "Sí, una vez cada media hora", correct: false, question_id: 5)
# Answer.create(text: "Depende", correct: false, question_id: 5)
# Answer.create(text: "Sí, todo el tiempo", correct: true, question_id: 5)


# # LEVEL ASADO
# Level.create(name:"Asado", text:"")

# Question.create(
#   text: "¿Cuál es el proceso principal para lograr un buen asado argentino?",
#   difficulty: 1,
#   link_imagen: "https://i.pinimg.com/564x/c5/44/d6/c544d60ead1c69a7be9aa9f451edb216.jpg",
#   levels_id: 2,
#   informed_text: "El Asado debe ser a fuego medio o a coccion lenta para que el asado no se arrebate."
# )
# Answer.create(text: "Cocción rápida a fuego alto", correct: false, question_id: 6)
# Answer.create(text: "Cocción lenta a fuego de leña o carbón", correct: true, question_id: 6)
# Answer.create(text: "Hervir la carne en agua antes de asarla", correct: false, question_id: 6)
# Answer.create(text: "Cocción en horno a temperatura media", correct: false, question_id: 6)

# Question.create(
#   text: "¿Qué tipo de madera es tradicionalmente utilizada para el fuego del asado?",
#   difficulty: 2,
#   link_imagen: "https://www.clarin.com/img/2022/08/09/wbvQ9lf2Z_1256x620__2.jpg#1660074352442",
#   levels_id: 2,
#   informed_text: "La madera de quebracho es la tradicionalmente utilizada para el fuego del asado. Esta madera proporciona un sabor distintivo y un aroma ahumado característico a la carne durante la cocción.\n
#                   Además, la madera de quebracho genera mas brasas."
# )
# Answer.create(text: "Madera de quebracho", correct: true, question_id: 7)
# Answer.create(text: "Madera de pino", correct: false, question_id: 7)
# Answer.create(text: "Madera de roble", correct: false, question_id: 7)
# Answer.create(text: "Madera de eucalipto", correct: false, question_id: 7)

# Question.create(
#   text: "¿Qué son las achuras en un asado argentino?",
#   difficulty: 1,
#   link_imagen: "https://i0.wp.com/www.brasasysabores.com/wp-content/uploads/2017/06/Las-achuras-como-parte-del-asado-argentino.jpg?resize=500%2C300&ssl=1",
#   levels_id: 2,
#   informed_text: "Las achuras en un asado argentino son las vísceras y órganos comestibles de la vaca. Estos cortes son apreciados por su sabor y se suelen cocinar a la parrilla junto con la carne principal del asado.
#                   La achura tripa gorda debe lavarse con agua fria para eliminar cualquier residuo adherido."
# )
# Answer.create(text: "Una salsa picante tradicional", correct: false, question_id: 8)
# Answer.create(text: "Una técnica de marinado", correct: false, question_id: 8)
# Answer.create(text: "Las vísceras y órganos comestibles de la vaca", correct: true, question_id: 8)
# Answer.create(text: "Un término para el punto de cocción", correct: false, question_id: 8)

# Question.create(
#   text: "¿Qué se recomienda hacer antes de poner la carne en la parrilla?",
#   difficulty: 1,
#   link_imagen: "https://supermercadoseven.com.ar/wp-content/uploads/2023/04/2000791000003_127.jpg",
#   levels_id: 2,
#   informed_text: "Antes de poner la carne en la parrilla, se recomienda salarla. El salado previo ayuda a realzar el sabor y jugosidad de la carne durante la cocción a la parrilla."
# )
# Answer.create(text: "Marinarla en salsa barbacoa", correct: false, question_id: 9)
# Answer.create(text: "Salarla", correct: true, question_id: 9)
# Answer.create(text: "Adobarla con especias", correct: false, question_id: 9)
# Answer.create(text: "Nada, se cocina tal cual", correct: false, question_id: 9)

# Question.create(
#   text: "¿Cuáles son los ingredientes principales del chimichurri argentino?",
#   difficulty: 1,
#   link_imagen: "https://www.lanacion.com.ar/resizer/XQHAykYUSJ_wo176UNcucFdLSVU=/1200x800/filters:format(webp):quality(80)/cloudfront-us-east-1.images.arcpublishing.com/lanacionar/TXPUINOZHFBEHCYRGIMWBMLDTE.jpg",
#   levels_id: 1,
#   informed_text: "El chimichurri es una salsa típica argentina utilizada como condimento para carnes. Sus ingredientes principales son el perejil, el ajo, el vinagre y el aceite de oliva."
# )
# Answer.create(text: "Tomate, cebolla, limón y aceite vegetal", correct: false, question_id: 10)
# Answer.create(text: "Mostaza, miel, salsa de soja y lima", correct: false, question_id: 10)
# Answer.create(text: "Cilantro, chile, jugo de limón y aceite de ajonjolí", correct: false, question_id: 10)
# Answer.create(text: "Perejil, ajo, vinagre y aceite de oliva", correct: true, question_id: 10)

  
# Level.create(name:"Locro", text:"Ingredientes: \n- 250g. de porotos blancos \n- 250g. de maíz \n- Chorizo colorado \n- Chorizo criollo \n- Cueritos de cerdo \n- Huesitos de cerdo \n- Falda \n- 200g. de panceta \n- 3 cebollas \n- 2 cebollas de verdeo \n- 1/2 calabaza \n- 1/2 morrón rojo (para la salsa)\n
#               Condimentos: sal, pimienta, comino, pimentón, ají molido, orégano \n
#               Pasos:\n
#               1- Cortar las carnes en trozos pequeños, las verduras en rodajas bien bien finitas y la calabaza en cubos\n los porotos y el maíz remojarlos desde la noche anterior en agua.\n
#               2- Colocar el chorizo, el cuerito, los huesitos y el chorizo colorado en una olla. \n Llevarlos al fuego 10-15 minutos hasta que hierva.\n
#               3- Integrar en una olla caliente la panceta para que largue su grasa, luego agregar la cebolla de verdeo, el puerro, sal, aceite de oliva y saltear todo.\n Una vez blandito agregar el chorizo colorado, los cueritos de cerdos, el chorizo, el maíz, los porotos blancos.\n Agregar agua, tapar y dejar cocinar 1 hora y media en olla común (revolviendo de vez en cuando y viendo si le falta más agua) o 1/2 hora en olla a presión.\n
#               4- A la olla con todos los ingredientes agregarle la calabaza cortada en cubos, el pechito, la falda, los condimentos, un poco más de agua y revolver bien. Dejar nuevamente 1/2 hora en olla a presión o una hora y media mas en olla común.\n
#               5- Preparar la salsita: picar el morrón, 1 cebolla de verdeo y 1 cebolla común bien bien finitos. \n Agregar ají molido (bastante si la queres más picante), pimentón y orégano.\nCocinar a fuego bajo en bastante aceite de oliva hasta que esté bien blandita la cebolla.\n
#               6- Espesar y servir con la salsa encima y la parte verde de la cebolla de verdeo picada. Si te sobra, podes freezarlo.")



# # LEVEL LOCRO
# Question.create(text:"¿Cuál es la comida tipica de las fechas patrias?", difficulty: 1, link_imagen: "https://media.istockphoto.com/id/1398880959/es/foto/s%C3%ADmbolo-de-signo-de-interrogaci%C3%B3n-para-preguntas-frecuentes-informaci%C3%B3n-problemas-y-conceptos.webp?b=1&s=170667a&w=0&k=20&c=dMaP3PbKWnVSVzNI5Um5LS9bfoTMD058sEPRkQ_6-EM=", levels_id: 3, informed_text: "El locro es una especie de guiso de origen argentino comido especialmente en fechas patrias como el 25 de mayo y el 9 de julio.")
# Answer.create(text: "Bagna Cauda", correct: false, question_id: 11)
# Answer.create(text: "Guiso", correct: false, question_id: 11)
# Answer.create(text: "Milanesa", correct: false, question_id: 11)
# Answer.create(text: "Locro", correct: true, question_id: 11)

# Question.create(text: "¿Cuáles son los ingredientes para preparar locro?", difficulty: 1, link_imagen: "https://upc.edu.ar/wp-content/uploads/2020/05/Locro_Stevage.jpg", levels_id: 3, informed_text: "El locro esta hecho a base de calabaza, maíz, poroto blanco ")
# Answer.create(text: "Calabaza, poroto, lentejas", correct: false, question_id: 12)
# Answer.create(text: "Calabaza, porotos, choclo", correct: true, question_id: 12)
# Answer.create(text: "Zapallito verde, choclo, arvejas", correct: false, question_id: 12)
# Answer.create(text: "Zapallito verde, choclos, porotos", correct: false, question_id: 12)

# Question.create(text: "¿Cuál es el tiempo estimado para hacer locro?", difficulty: 1, link_imagen: "https://previews.123rf.com/images/kongvector/kongvector1801/kongvector180101987/93077357-chef-del-reloj-de-alarma-de-dibujos-animados-del-car%C3%A1cter.jpg", levels_id: 3, informed_text: "El tiempo estimado es muy largo ya que se deben ir cocinando los distintos ingredientes en tiempos distintos y algunos por separado.")
# Answer.create(text: "1 hora", correct: false, question_id: 13)
# Answer.create(text: "Al menos 2 horas", correct: false, question_id: 13)
# Answer.create(text: "1/2 hora, aproximadamente", correct: false, question_id: 13)
# Answer.create(text: "Alrededor de 4 horas", correct: true, question_id: 13)

# Question.create(text: "¿LLeva panceta?", difficulty: 1, link_imagen: "https://okdiario.com/img/2021/02/19/panceta-de-cerdo-5-620x465.jpg", levels_id: 3)
# Answer.create(text: "No", correct: false, question_id: 14)
# Answer.create(text: "Si, 200 gr", correct: true, question_id: 14)

# Question.create(text: "¿Con cuanta cantidad se condimenta el locro con pimenton?", difficulty: 1, link_imagen: "https://cdn.businessinsider.es/sites/navi.axelspringer.es/public/media/image/2021/06/pimenton-vera-2364603.jpg?tf=3840x", levels_id: 3, informed_text: "Cada persona condimenta a gusto, para asi poder comerlo como mas le guste.")
# Answer.create(text: "20 gr", correct: false, question_id: 15)
# Answer.create(text: "100 gr", correct: false, question_id: 15)
# Answer.create(text: "A gusto", correct: true, question_id: 15)
# Answer.create(text: "500gr", correct: false, question_id: 15)

# Question.create(text: "¿Que ingredientes lleva la salsa?", difficulty: 1, link_imagen: "https://media.istockphoto.com/id/1398880959/es/foto/s%C3%ADmbolo-de-signo-de-interrogaci%C3%B3n-para-preguntas-frecuentes-informaci%C3%B3n-problemas-y-conceptos.webp?b=1&s=170667a&w=0&k=20&c=dMaP3PbKWnVSVzNI5Um5LS9bfoTMD058sEPRkQ_6-EM=", levels_id: 3, informed_text: "Una vez servido en los platos se le pude agregar una salsa por arriba.")
# Answer.create(text: "Cebolla, cebolla de verdeo, morron", correct: true, question_id: 16)
# Answer.create(text: "Cebolla y morron", correct: false, question_id: 16)
# Answer.create(text: "Cebolla de verdeo y morron ", correct: false, question_id: 16)
# Answer.create(text: "Cebolla y cebolla de verdeo", correct: false, question_id: 16)

  
# # FRONTERA A CHILE
# Level.create(id: 1000, name:"Frontera a Chile", text:"")

# #DULCE DE LECHE EVALUATE
# qev1 = Question.create(text:"¿Por qué el Dulce de Leche se debe revolver constantemente durante su preparación?", difficulty: 3, link_imagen: "https://www.cucinare.tv/wp-content/uploads/2019/10/Dulce-de-leche.jpg", levels_id: 1000)
# Answer.create(text: "Para que la vainilla se concentre correctamente", correct: false, question: qev1)
# Answer.create(text: "No debe revolverse", correct: false, question: qev1)
# Answer.create(text: "Para que la leche no haga grumos", correct: false, question: qev1)
# Answer.create(text: "Para que no se pegue al fondo de la olla", correct: true, question: qev1)

# qev2 = Question.create(text:"¿Por qué la cocción del Dulce de Leche tarda alrededor de 2 horas?", difficulty: 3, link_imagen: "https://www.cucinare.tv/wp-content/uploads/2019/10/Dulce-de-leche.jpg", levels_id: 1000)
# Answer.create(text: "Para luego ser llevado a baño maría", correct: false, question: qev2)
# Answer.create(text: "La cocción tarda 7 horas", correct: false, question: qev2)
# Answer.create(text: "Para lograr la textura y el color caracteristico", correct: true, question: qev2)
# Answer.create(text: "Para que la leche no se corte", correct: false, question: qev2)

# qev3 = Question.create(text:"¿Qué rol cumple la vainilla en su preparación?", difficulty: 3, link_imagen: "https://www.cucinare.tv/wp-content/uploads/2019/10/Dulce-de-leche.jpg", levels_id: 1000)
# Answer.create(text: "Dar un poco de aroma", correct: true, question: qev3)
# Answer.create(text: "Le da un color amarronado más intenso", correct: false, question: qev3)
# Answer.create(text: "Puede utilizarse para suplantar a las avellanas", correct: false, question: qev3)
# Answer.create(text: "Para que no caiga pesado al comerlo", correct: false, question: qev3)

# qev4 = Question.create(text:"¿El Dulce de Leche contiene TACC?", difficulty: 3, link_imagen: "https://www.cucinare.tv/wp-content/uploads/2019/10/Dulce-de-leche.jpg", levels_id: 1000)
# Answer.create(text: "Sí", correct: false, question: qev4)
# Answer.create(text: "No", correct: true, question: qev4)
# Answer.create(text: "Dependera de la azúcar que usemos", correct: false, question: qev4)
# Answer.create(text: "Dependera de la leche que usemos", correct: false, question: qev4)

# #ASADO EVALUATE
# qev5 = Question.create(text:"¿Por qué la cocción del asado debe ser lenta y a fuego medio?", difficulty: 3, link_imagen: "https://i.pinimg.com/564x/c5/44/d6/c544d60ead1c69a7be9aa9f451edb216.jpg", levels_id: 1000)
# Answer.create(text: "No es necesario si la carne se hierve antes", correct: false, question: qev5)
# Answer.create(text: "Para que quede mas tierno", correct: false, question: qev5)
# Answer.create(text: "Para utilizar menos leña y carbón", correct: false, question: qev5)
# Answer.create(text: "Para que no se arrebate", correct: true, question: qev5)

# qev6 = Question.create(text:"¿Cuál es el proposito de lavar la tripa gorda?", difficulty: 3, link_imagen: "https://i.pinimg.com/564x/c5/44/d6/c544d60ead1c69a7be9aa9f451edb216.jpg", levels_id: 1000)
# Answer.create(text: "Eliminar cualquier residuo adherido al interior", correct: true, question: qev6)
# Answer.create(text: "Que se haga mas rápido", correct: false, question: qev6)
# Answer.create(text: "No debe lavarse si el animal era chico", correct: false, question: qev6)
# Answer.create(text: "Si no se lava le da más sabor", correct: false, question: qev6)

# qev7 = Question.create(text:"¿Por qué debe salarse la carne antes de cocinarla?", difficulty: 3, link_imagen: "https://i.pinimg.com/564x/c5/44/d6/c544d60ead1c69a7be9aa9f451edb216.jpg", levels_id: 1000)
# Answer.create(text: "Para no tener colesterol", correct: false, question: qev7)
# Answer.create(text: "Ayuda a que la misma sea mas tierna", correct: false, question: qev7)
# Answer.create(text: "La carne debe salarse recién cuando esta servida en la mesa", correct: false, question: qev7)
# Answer.create(text: "Ayuda a realzar el sabor y la jugosidad de la carne", correct: true, question: qev7)

# qev8 = Question.create(text:"¿Por qué generalmente se utiliza madera de quebracho?", difficulty: 3, link_imagen: "https://i.pinimg.com/564x/c5/44/d6/c544d60ead1c69a7be9aa9f451edb216.jpg", levels_id: 1000)
# Answer.create(text: "Porque es la mas barata", correct: false, question: qev8)
# Answer.create(text: "Porque no hay otra", correct: false, question: qev8)
# Answer.create(text: "Porque genera más brasas que otras y le da un sabor distintivo", correct: true, question: qev8)
# Answer.create(text: "La madera de pino es la madera comunmente utilizada para un asado", correct: false, question: qev8)


# ## LOCRO EVALUATE
# qev9 = Question.create(text:"¿Por qué la cocción del locro lleva alrededor de 4 horas?", difficulty: 3, link_imagen: "https://upc.edu.ar/wp-content/uploads/2020/05/Locro_Stevage.jpg", levels_id: 1000)
# Answer.create(text: "Algunos ingredientes deben cocinarse por separado", correct: true, question: qev9)
# Answer.create(text: "Si no no queda tan picante", correct: false, question: qev9)
# Answer.create(text: "El poroto desprende una esencia caracteristica", correct: false, question: qev9)
# Answer.create(text: "Por la calabaza que tarda bastante", correct: false, question: qev9)

# qev10 = Question.create(text:"¿Cómo se cocina el locro?", difficulty: 3, link_imagen: "https://upc.edu.ar/wp-content/uploads/2020/05/Locro_Stevage.jpg", levels_id: 1000)
# Answer.create(text: "En una olla, como un guiso", correct: true, question: qev10)
# Answer.create(text: "Al horno, en una asadera", correct: false, question: qev10)
# Answer.create(text: "En un horno de barro", correct: false, question: qev10)
# Answer.create(text: "Frito", correct: false, question: qev10)

# qev11 = Question.create(text:"¿Puede agregarsele una salsa extra?", difficulty: 3, link_imagen: "https://upc.edu.ar/wp-content/uploads/2020/05/Locro_Stevage.jpg", levels_id: 1000)
# Answer.create(text: "Sí, media hora antes de que esté listo", correct: false, question: qev11)
# Answer.create(text: "No", correct: false, question: qev11)
# Answer.create(text: "Siempre y cuando esta lleve tomate", correct: false, question: qev11)
# Answer.create(text: "Sí, una vez servido en los platos", correct: true, question: qev11)