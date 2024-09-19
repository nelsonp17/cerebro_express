import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Pages
import 'pages/register.dart';
import 'pages/home.dart';
import 'pages/scene.dart';
import 'utils/constants.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://ezxjdxoncucdyfjkpona.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImV6eGpkeG9uY3VjZHlmamtwb25hIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjQxMjY3MzYsImV4cCI6MjAzOTcwMjczNn0.y_bS7geu7iDp_QiPMGztFJP7TV_cB3mvA-AQkGTxQ2M',
  );

  runApp(MaterialApp(
    title: appName,
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue.shade900),
      useMaterial3: true,
    ),
    initialRoute: '/',
    routes: {
      '/': (context) => const HomePage(),
      '/register': (context) => const RegisterPage(),
      '/scene': (context) => const ScenePage(),
    },
  ));
}

final supabase = Supabase.instance.client;
