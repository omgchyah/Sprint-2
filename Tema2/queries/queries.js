
//1. Escriu una consulta per mostrar tots els documents en la col·lecció Restaurants.
db.inventory.find({})

//2. Escriu una consulta per mostrar el restaurant_id, name, borough i cuisine de tots els documents en la col·lecció Restaurants.
db.restaurant.find({}, {restaurant_id: 1, name: 1, borough: 1, cuisine: 1})

//3. Escriu una consulta per mostrar el restaurant_id, name, borough i cuisine, però excloent el camp _id per tots els documents en la col·lecció Restaurants.
db.restaurant.find({}, {_id: 0, restaurant_id: 1, name: 1, borough: 1, cuisine: 1})

//4. Escriu una consulta per mostrar restaurant_id, name, borough i zip code, però excloent el camp _id per tots els documents en la col·lecció Restaurants.
db.restaurant.find({}, {_id: 0, restaurant_id: 1, name: 1, borough: 1, "address.zipcode": 1 })

//5.Escriu una consulta per mostrar tots els restaurants que estan en el Bronx
db.restaurant.find({borough: "Bronx"})

//6.Escriu una consulta per mostrar els primers 5 restaurants que estan en el Bronx.
db.restaurant.find({borough: "Bronx"}).limit(5)

//7.Escriu una consulta per mostrar els 5 restaurants després de saltar els primers 5 que siguin del Bronx.
db.restaurant.find({borough: "Bronx"}).skip(5).limit(5)

//8. Escriu una consulta per trobar els restaurants que tenen algun score més gran de 90.
db.restaurant.find({grades: {$elemMatch: {score: {$gt: 90}}}})

//9. Escriu una consulta per trobar els restaurants que tenen un score més gran que 80 però menys que 100.
db.restaurant.find({$and: [{grades: {$elemMatch: {score: {$gt: 90}}}}, {grades: {$elemMatch: {score: {$lt: 100}}}}]})
db.restaurant.find({"grades.score": { $gt: 80, $lt: 100 }})

//10. Escriu una consulta per trobar els restaurants que estan situats en una longitud inferior a -95.754168.
db.restaurant.find({"address.coord": {$lt: -95.754168}})

//11. Escriu una consulta de MongoDB per a trobar els restaurants que no cuinen menjar 'American ' i tenen algun score superior a 70 i latitud inferior a -65.754168.
db.restaurant.find({
    cuisine: { $ne: "American" }, // cuisine is not equal to "American"
    "grades.score": { $gt: 70 }, // score is greater than 70
    "address.coord.0": { $lt: -65.754168 } // latitude is less than -65.754168
})

//12. Escriu una consulta per trobar els restaurants que no preparen menjar 'American' i tenen algun score superior a 70 i que, a més, es localitzen en longituds inferiors a -65.754168. Nota: Fes aquesta consulta sense utilitzar operador $and.


//13. Escriu una consulta per trobar els restaurants que no preparen menjar 'American ', tenen alguna nota 'A' i no pertanyen a Brooklyn. S'ha de mostrar el document segons la cuisine en ordre descendent.


//14. Escriu una consulta per trobar el restaurant_id, name, borough i cuisine per a aquells restaurants que contenen 'Wil' en les tres primeres lletres en el seu nom.


//15. Escriu una consulta per trobar el restaurant_id, name, borough i cuisine per a aquells restaurants que contenen 'ces' en les últimes tres lletres en el seu nom.


//16. Escriu una consulta per trobar el restaurant_id, name, borough i cuisine per a aquells restaurants que contenen 'Reg' en qualsevol lloc del seu nom.


//17. Escriu una consulta per trobar els restaurants que pertanyen al Bronx i preparen plats Americans o xinesos.

