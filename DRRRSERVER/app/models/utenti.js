var Utente = {
    nome: String,
    password: String,
    pic: String,
    punti: Number,
    livello: Number,
    set: function(name, psw, img, point, lv) {
        nome = name;
        password = psw;
        pic = img;
        punti = point;
        livello = lv;
    }
 };
  
 module.exports = Utente;