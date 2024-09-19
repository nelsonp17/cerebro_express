import 'package:flutter/material.dart';
import 'package:startapp_sdk/startapp.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Primera Pantalla'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Ir a la Segunda Pantalla'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SecondPage()),
            );
          },
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Segunda Pantalla'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Volver'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}

class ScenePageText extends StatefulWidget {
  const ScenePageText({super.key});

  @override
  State<ScenePageText> createState() => _ScenePageTextState();
}

class _ScenePageTextState extends State<ScenePageText> {
  int _counter = 0;
  String msj = "Este mensaje, No iniciado...";
  var startAppSdk = StartAppSdk();

  StartAppBannerAd? bannerAd;

  @override
  void initState() {
    super.initState();
    loadBanner();
  }

  void loadBanner() {
    setState(() {
      msj = "Iniciando...";
    });

    startAppSdk.setTestAdsEnabled(true);

    startAppSdk.loadBannerAd(StartAppBannerType.BANNER).then((bannerAd) {
      setState(() {
        this.bannerAd = bannerAd;
      });
      setState(() {
        msj = "Cargado";
      });
    }).onError<StartAppException>((ex, stackTrace) {
      var errorMsj = "Error loading Banner ad1: ${ex.message}";
      debugPrint(errorMsj);
      setState(() {
        msj = errorMsj;
      });
    }).onError((error, stackTrace) {
      var errorMsj = "Error loading Banner ad2: $error";
      debugPrint(errorMsj);
      setState(() {
        msj = errorMsj;
      });
    });
  }

  void _incrementCounter() {
    loadBanner();
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          colors: [Colors.green, Colors.greenAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        )),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Hola mundo:',
              ),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Text(msj),
              const Column(
                children: [
                  //bannerAd != null ? StartAppBanner(bannerAd!) : Container()
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
