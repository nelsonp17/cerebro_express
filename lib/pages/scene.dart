import 'package:flutter/material.dart';
import 'package:startapp_sdk/startapp.dart';

class ScenePage extends StatefulWidget {
  const ScenePage({super.key});

  @override
  State<ScenePage> createState() => _ScenePageState();
}

class _ScenePageState extends State<ScenePage> {
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
