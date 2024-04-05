### PA2

Der er i dette projekt anvendt mysqlcppconn til at forbinde c++ programmet til en mysql database.
Kompilering kan gøres ved brug af mysqlcppconn og vedlagte CMakeLists.txt fil. 

Hvis der er lyst til at teste programmet kan sql filen køres en gang for at oprette en database.
Opgaverne kan testes ved brug af nogle funktioner, der er skrevet i programmet. I main funktionen er der tilføjet
så man opretter en instans af en robot, kaldt robot, hvorefter de forskellige robotter udskrives.
Samtidig bliver man queriet i terminalen om oprettelse af en ny task. 
Derfra kan man i main funktionen angive under rb.completeTask(), hvilken opgave robotten skal udføre.

Der ligger en sql fil hvor de forskellige queries til oprettelse af databasen står i. Dermed opgave 1, 5 og en del af opgave 7. For at løse opgave 7
så er der lavet en bool til at holde styr på, om der er en robot som arbejder på det givne task. 

