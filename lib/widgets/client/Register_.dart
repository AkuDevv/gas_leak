import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gas_leak_safety/widgets/verify_email.dart';
import 'package:gas_leak_safety/services/auth_service.dart';

class FirstLanding extends StatefulWidget {
  const FirstLanding({Key? key}) : super(key: key);

  @override
  _FirstLandingState createState() => _FirstLandingState();
}

class _FirstLandingState extends State<FirstLanding> {
  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController cinController = TextEditingController();
  TextEditingController telController = TextEditingController();
  TextEditingController adresseController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool loading = false;
  final _formkey = GlobalKey<FormState>();

  bool showPassword = true;
  bool showConfirmPassword = true;

  final int _numPages = 2;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? const Color(0xff00366f) : Colors.grey,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Color(0xff00366f)),
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30.0),
          child: ListView(
            children: <Widget>[
              Center(
                child: SizedBox(
                  width: 110,
                  height: 110,
                  child: Image.asset("assets/images/logo_.png"),
                ),
              ),
              const Center(
                child: Text(
                  "Cr??er votre compte",
                  style: TextStyle(
                    fontSize: 25,
                    color: Color(0xff00366f),
                    fontFamily: 'Sfpro',
                  ),
                ),
              ),
              Container(
                height: 400,
                child: Form(
                  key: _formkey,
                  child: PageView(
                    allowImplicitScrolling: true,
                    pageSnapping: true,
                    physics: const ClampingScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: <Widget>[
                            const SizedBox(
                              height: 20,
                            ),

                            // FIRST NAME TEXT FIELD
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: TextFormField(
                                validator: (fname) => fname!.isEmpty
                                    ? "Entrez votre pr??nom!"
                                    : null,
                                controller: fnameController,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                style: const TextStyle(
                                    fontSize: 15, fontFamily: 'Sfpro'),
                                decoration: InputDecoration(
                                    labelText: " Pr??nom ",
                                    labelStyle: const TextStyle(
                                        fontSize: 14, fontFamily: 'Sfpro'),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    contentPadding: const EdgeInsets.all(10)),
                              ),
                            ),

                            // LAST NAME TEXT FIELD
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: TextFormField(
                                validator: (name) =>
                                    name!.isEmpty ? "Entrez votre nom!" : null,
                                controller: lnameController,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                style: const TextStyle(
                                    fontSize: 15, fontFamily: 'Sfpro'),
                                decoration: InputDecoration(
                                    labelText: " Nom ",
                                    labelStyle: const TextStyle(
                                        fontSize: 14, fontFamily: 'Sfpro'),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    contentPadding: const EdgeInsets.all(10)),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: TextFormField(
                                validator: (cin) =>
                                    cin!.isEmpty ? "Entrez votre CIN!" : null,
                                controller: cinController,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                style: const TextStyle(
                                    fontSize: 15, fontFamily: 'Sfpro'),
                                decoration: InputDecoration(
                                    labelText: " CIN ",
                                    labelStyle: const TextStyle(
                                        fontSize: 14, fontFamily: 'Sfpro'),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    contentPadding: const EdgeInsets.all(10)),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: TextFormField(
                                validator: (tel) => tel!.isEmpty
                                    ? "Entrez votre num??ro de t??l??phone"
                                    : null,
                                controller: telController,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                style: const TextStyle(
                                    fontSize: 15, fontFamily: 'Sfpro'),
                                decoration: InputDecoration(
                                    labelText: " Num??ro T??l??phone ",
                                    labelStyle: const TextStyle(
                                        fontSize: 14, fontFamily: 'Sfpro'),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    contentPadding: const EdgeInsets.all(10)),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: TextFormField(
                                validator: (adresse) => adresse!.isEmpty
                                    ? "Entrez votre adresse!"
                                    : null,
                                controller: adresseController,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                style: const TextStyle(
                                    fontSize: 15, fontFamily: 'Sfpro'),
                                decoration: InputDecoration(
                                    labelText: " Adresse Postale ",
                                    labelStyle: const TextStyle(
                                        fontSize: 14, fontFamily: 'Sfpro'),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    contentPadding: const EdgeInsets.all(10)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: TextFormField(
                                validator: (email) =>
                                    !EmailValidator.validate(email!)
                                        ? "Entez un email valide!"
                                        : null,
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                style: const TextStyle(
                                    fontSize: 15, fontFamily: 'Sfpro'),
                                decoration: InputDecoration(
                                    labelText: " Email ",
                                    prefixIcon: const Icon(Icons.email),
                                    labelStyle: const TextStyle(
                                        fontSize: 14, fontFamily: 'Sfpro'),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    contentPadding: const EdgeInsets.all(10)),
                                autofillHints: const [AutofillHints.email],
                              ),
                            ),

                            // PASSWORD TEXT FIELD
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: TextFormField(
                                validator: (password) {
                                  if (password!.isEmpty) {
                                    return "Entez un mot de passe!";
                                  } else if (password.length < 6) {
                                    return "6 caract??res minimum!";
                                  } else {
                                    return null;
                                  }
                                },
                                controller: passwordController,
                                textInputAction: TextInputAction.next,
                                obscureText: showPassword,
                                style: const TextStyle(
                                    fontSize: 15, fontFamily: 'Sfpro'),
                                decoration: InputDecoration(
                                    labelText: " Mot de passe ",
                                    prefixIcon: const Icon(Icons.lock),
                                    labelStyle: const TextStyle(
                                        fontSize: 14, fontFamily: 'Sfpro'),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    contentPadding: const EdgeInsets.all(10),
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            showPassword = !showPassword;
                                          });
                                        },
                                        icon: showPassword
                                            ? const Icon(Icons.visibility)
                                            : const Icon(
                                                Icons.visibility_off))),
                              ),
                            ),

                            // CONFIRM PASSWORD TEXT FIELD
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: TextFormField(
                                validator: (value) => passwordController.text !=
                                        confirmPasswordController.text
                                    ? "Mot de passe non correcte!"
                                    : null,
                                controller: confirmPasswordController,
                                textInputAction: TextInputAction.done,
                                obscureText: showConfirmPassword,
                                style: const TextStyle(
                                    fontSize: 15, fontFamily: 'Sfpro'),
                                decoration: InputDecoration(
                                    labelText: " Confirmer le mot de passe ",
                                    prefixIcon: const Icon(Icons.lock),
                                    labelStyle: const TextStyle(
                                        fontSize: 14, fontFamily: 'Sfpro'),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    contentPadding: const EdgeInsets.all(10),
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            showConfirmPassword =
                                                !showConfirmPassword;
                                          });
                                        },
                                        icon: showConfirmPassword
                                            ? const Icon(Icons.visibility)
                                            : const Icon(
                                                Icons.visibility_off))),
                              ),
                            ),

                            // REGISTER BUTTON
                            loading
                                ? const Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      height: 40,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            gradient: const LinearGradient(
                                                colors: [
                                                  Color(0xff00366f),
                                                  Color(0xffd51b33)
                                                ],
                                                stops: [
                                                  0.1,
                                                  0.9
                                                ])),
                                        child: TextButton(
                                            onPressed: () async {
                                              if (!_formkey.currentState!
                                                      .validate() ==
                                                  true) {
                                                return;
                                              }
                                              setState(() {
                                                loading = true;
                                              });
                                              User? user = await AuthService()
                                                  .register(
                                                      emailController.text,
                                                      passwordController.text,
                                                      context);
                                              if (user != null) {
                                                CollectionReference users =
                                                    firebaseFirestore
                                                        .collection('users');
                                                await users.doc(user.uid).set({
                                                  'name':
                                                      "${fnameController.text} ${lnameController.text}",
                                                  'email': emailController.text,
                                                  'cin': cinController.text,
                                                  'tel': telController.text,
                                                  'adresse':
                                                      adresseController.text,
                                                  'latitude': 1.1,
                                                  'longitude': 1.1,
                                                  'photo': "",
                                                  'uid': user.uid,
                                                  'provider': "EMAIL",
                                                  'password':
                                                      passwordController.text,
                                                }).then((value) =>
                                                    users
                                                        .doc(user.uid)
                                                        .collection(
                                                            'historiques')
                                                        .doc(user.uid)
                                                        .set({
                                                      'date': ' ',
                                                      'heure': '',
                                                      'intervention': false
                                                    }));
                                                // ignore: use_build_context_synchronously
                                                Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const VerifyEmailScreen()));
                                              }
                                              setState(() {
                                                loading = false;
                                              });
                                            },
                                            child: const Text(
                                              "S'inscrire",
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white,
                                                fontFamily: 'Sfpro',
                                              ),
                                            )),
                                      ),
                                    ),
                                  ),

                            // LOGIN BUTTON
                            Center(
                              child: TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("Vous avez d??ja un compte?",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'Sfpro',
                                      color: Color(0xff00366f),
                                    )),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _buildPageIndicator(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
