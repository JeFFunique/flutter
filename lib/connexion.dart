import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'inscription.dart';

//------------------------------------------------------------------------------

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async{
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

/*
  //Pour se déconnecter de la session
  Future<void> signOut() async{
    await _firebaseAuth.signOut();
  }
  */
}

//------------------------------------------------------------------------------

class ConnexionScreen extends StatefulWidget {
  const ConnexionScreen({Key? key}) : super(key: key);

  @override
  State<ConnexionScreen> createState() => _ConnexionScreenState();
}

class _ConnexionScreenState extends State<ConnexionScreen> {

  String? errorMessage = '';
  bool isLogin = true;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> signInWithEmailAndPassword() async{
    try {
      await Auth().signInWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }

    /*
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Accueil()),
    );
    */
  }

  Future<void> createUserWithEmailAndPassword() async{
    try {
      await Auth().createUserWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Container : parent
      body: Container(
        //Mettre l'image background
        width: double.infinity, //prend toute la largeur de l'écran
        height: double.infinity, //pareil pour la hauteur
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),

        child: Center(
          //permet de centrer le widget column dans le widget parent (container)
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [

              const Text(
                'Bienvenue !',
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(height: 15), //Se réfère au widget Text


              const SizedBox(
                height:80,
                width: 210,
                child: Text(
                  'Veuillez vous connecter ou créer un nouveau compte pour utiliser l\'application.',
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 15),


              SizedBox(
                width: 350,
                child: TextField(
                  controller: _controllerEmail,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xFF1E262C),
                      label: Center(
                        child: Text('E-mail'),
                      ),
                      labelStyle: TextStyle(color: Colors.white)
                  ),
                ),
              ),
              const SizedBox(height: 20),


              SizedBox(
                width: 350,
                child: TextField(
                  controller: _controllerPassword,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xFF1E262C),
                      label: Center(
                        child: Text('Mot de passe'),
                      ),
                      labelStyle: TextStyle(color: Colors.white)
                  ),
                ),
              ),
              const SizedBox(height: 20),


              ElevatedButton(
                onPressed: () {
                  signInWithEmailAndPassword();
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(350, 55),
                  backgroundColor: const Color(0xFF636AF6),
                ),
                child: const Text('Se connecter'),
              ),
              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const InscriptionScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(350, 55),
                  side: const BorderSide(width: 2, color: Color(0xff636AF6)),
                  backgroundColor: Colors.transparent,
                ),
                child: const Text('Créer un nouveau compte'),
              ),
              const SizedBox(height: 20),

            ],
          ),
        ),
      ),
    );
  }
}

