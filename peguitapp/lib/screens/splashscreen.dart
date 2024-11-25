import 'package:flutter/material.dart';
import 'package:peguitapp/main.dart'; //Importa MainApp

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double opacity = 1.0; // Opacidad inicial

  @override
  void initState() {
    super.initState();
    // Inicia la animación
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        opacity = 0.0; // Cambia la opacidad a 0
      });

      // Navega a HomeScreen después de la espera y la animación
      Future.delayed(const Duration(milliseconds: 500), () {
        Navigator.pushReplacement(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,

      body: Center(
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 500), // Duración de la animación
          opacity: opacity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'lib/assets/images/rayo.png',
                width: 100,
                height: 100,
               ),
               const SizedBox(height: 10),
               const Text(
                'PeguitApp',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: Colors.white,
                ),
               ),
            ],
          ),
          ),
        ),
      );
  }
}
