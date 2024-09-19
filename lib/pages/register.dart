import 'package:cached_network_image/cached_network_image.dart';
import 'package:cerebro_express/utils/supabase.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../theme.dart';

final supabase = Supabase.instance.client;

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //final response = supabase.from('games').select();
  String nameGame = "";

  @override
  void initState() {
    super.initState();

    supabaseSelect("games").then((response) {
      response.forEach((data) {
        setState(() {
          nameGame = data.values.elementAt(2);
        });
      });
    });
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
                                'Formulario de Registro',
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
                            //key: _model.formKey,
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
                                    //    .passwordTextFieldTextControllerValidator
                                    //    .asValidator(context),
                                  ),
                                ),
                                Align(
                                  alignment: const AlignmentDirectional(1, 0),
                                  child: Padding(
                                    padding: const EdgeInsetsDirectional.only(
                                        end: 10),
                                    child: TextButton(
                                        onPressed: () {
                                          Navigator.pushNamed(context, '/');
                                        },
                                        child: const Text(
                                          '¿Tienes una cuenta? Inicia sesión',
                                          style: TextStyle(
                                            fontFamily: 'Readex Pro',
                                            color: colorTextLink,
                                            letterSpacing: 0,
                                          ),
                                        )),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 10, 0, 30),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      print('Button pressed ...');
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
                                      'Registrarse',
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
