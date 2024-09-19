import 'package:cached_network_image/cached_network_image.dart';
import 'package:cerebro_express/utils/supabase.dart';
import 'package:cerebro_express/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../interface/supabase.dart';
import '../theme.dart';
import '../utils/utils.dart';

final supabase = Supabase.instance.client;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //final response = supabase.from('games').select();
  String nameGame = "";

  String email = "";
  String password = "";
  late UserCredential user;
  late UserData userData;

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    getPlatform();

    supabaseSelect("games").then((response) {
      response.forEach((data) {
        setState(() {
          nameGame = data.values.elementAt(2);
        });
      });
    });
  }

  void handleLogin(BuildContext contect) {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      user = UserCredential(email: email, password: password);

      // buscamos si existe
      handleDB(user);

      formKey.currentState!.reset();

      Navigator.pushNamed(context, "/register");
    }
  }

  Future<void> handleDB(UserCredential user) async {
    // buscamos si existe
    var response =
        await supabase.from("users").select().eq("email", email).limit(1);

    bool isCreate = false;

    print(response);

    if (response.isEmpty) {
      // no existe, lo creo
      isCreate = true;
      int avatar = generarNumeroAleatorio();
      await supabase
          .from("users")
          .insert({'email': email, 'avatar': "$avatar"});

      // lo buscamos
      response =
          await supabase.from("users").select().eq("email", email).limit(1);
    }

    // seteamos
    response.forEach((data) {
      final id = data.values.elementAt(0);
      final created_at = data.values.elementAt(1);
      final uuid = data.values.elementAt(2);
      final email = data.values.elementAt(3);
      final avatar = data.values.elementAt(4);

      userData = UserData(
          email: email,
          password: password,
          uuid: uuid,
          avantar: avatar,
          id: id);
    });

    // iniciamos sesion con supabase
    if (isCreate) {
      await supabase.auth.signUp(
        email: email,
        password: password,
      );
    } else {
      await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorPrimary,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(20, 50, 20, 50),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    color: Colors.white,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: CachedNetworkImage(
                              fadeInDuration: const Duration(milliseconds: 500),
                              fadeOutDuration:
                                  const Duration(milliseconds: 500),
                              imageUrl: imageLogoWeb192,
                              width: 300,
                              height: 150,
                              fit: BoxFit.contain,
                            ),
                          ),
                          const Align(
                            alignment: AlignmentDirectional(0, 0),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 20, 0, 20),
                              child: Text(
                                'Iniciar Sesión / Registro',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 24,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                          Form(
                            key: formKey,
                            autovalidateMode: AutovalidateMode.disabled,
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                const Align(
                                  alignment: AlignmentDirectional(-1, 0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        8, 0, 0, 5),
                                    child: Text(
                                      'Correo Electrónico',
                                      style: TextStyle(
                                        fontFamily: 'Readex Pro',
                                        color: colorBlackText,
                                        letterSpacing: 0,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      8, 0, 8, 15),
                                  child: TextFormField(
                                    autofocus: true,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelStyle: const TextStyle(
                                        fontFamily: 'Readex Pro',
                                        letterSpacing: 0,
                                      ),
                                      hintStyle: const TextStyle(
                                        fontFamily: 'Readex Pro',
                                        letterSpacing: 0,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: colorBlackText,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: colorBlackText,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: colorRedError,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: colorRedError,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    style: const TextStyle(
                                      fontFamily: 'Readex Pro',
                                      letterSpacing: 0,
                                    ),
                                    //validator: _model
                                    //    .emailTextFieldTextControllerValidator
                                    //    .asValidator(context),
                                    onSaved: (value) {
                                      email = value!;
                                    },
                                    validator: Validators.validateEmail,
                                  ),
                                ),
                                const Align(
                                  alignment: AlignmentDirectional(-1, 0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        8, 0, 0, 5),
                                    child: Text(
                                      'Contraseña',
                                      style: TextStyle(
                                        fontFamily: 'Readex Pro',
                                        letterSpacing: 0,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      8, 0, 8, 10),
                                  child: TextFormField(
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        labelStyle: const TextStyle(
                                          fontFamily: 'Readex Pro',
                                          letterSpacing: 0,
                                        ),
                                        hintStyle: const TextStyle(
                                          fontFamily: 'Readex Pro',
                                          letterSpacing: 0,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: colorBlackText,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: colorBlackText,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: colorRedError,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: colorRedError,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                      style: const TextStyle(
                                        fontFamily: 'Readex Pro',
                                        letterSpacing: 0,
                                      ),
                                      validator: Validators.validatePassword,
                                      onSaved: (value) {
                                        password = value!;
                                      }),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 10, 0, 30),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      handleLogin(context);
                                    },
                                    style: const ButtonStyle(
                                      padding: WidgetStatePropertyAll(
                                        EdgeInsets.only(
                                            top: 15,
                                            bottom: 15,
                                            left: 24,
                                            right: 24),
                                      ),
                                      elevation: WidgetStatePropertyAll(3),
                                      backgroundColor:
                                          WidgetStatePropertyAll(colorPrimary),
                                      shadowColor: WidgetStatePropertyAll(
                                          colorTansparent),
                                    ),
                                    child: const Text(
                                      'Comenzar',
                                      style: TextStyle(
                                        fontFamily: 'Readex Pro',
                                        color: colorLightText,
                                        letterSpacing: 0,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
