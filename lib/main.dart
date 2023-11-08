import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark(),
      home: SignInScreen(),
    );
  }
}

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [Colors.blue, Colors.tealAccent])
        ),
        child: Card(
          margin: const EdgeInsets.only(top: 200, bottom: 200),
          elevation: 20,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("Google Login",style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Padding(padding: const EdgeInsets.all(20),
              child: MaterialButton(color: Colors.yellowAccent, onPressed: () {}, child: Text("Login with Google")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final FirebaseAuth _auth = FirebaseAuth.instance;

Future<void>signIn(BuildContext context) async{
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
  if(googleSignInAccount!=null){
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken);
    UserCredential result = await _auth.signInWithCredential(credential);
    User? user =result.user;
    print(user!.email);
    print(user!.displayName);
    //TODO Validar usuario y navegar a la pantalla de inicio

  }
}
