import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.menu), // Ícono de menú
          title: const Text('Diagramación'), // Título de la AppBar
          actions: const [
            Icon(Icons.more_vert), // Ícono de more_vert
          ],
        ),
        body: ListView(
          children: [
            Container(
              height: 570.0, // Altura de 570 píxeles
              width: double.infinity, // Ocupa todo el ancho disponible
              color: Colors.grey, // Color de fondo gris
              child: const Center(child: Text('Hello World!')), // Texto dentro del primer Container
            ),
            const SizedBox(height: 12.0), // Espacio de 12 píxeles entre los containers
            Container(
              height: 148.0, // Altura de 148 píxeles
              width: double.infinity, // Ocupa todo el ancho disponible
              color: Colors.blue, // Color de fondo azul
              child: const Center(child: Text('Segundo Container')), // Texto dentro del segundo Container
            ),
            const SizedBox(height: 12.0), // Espacio de 12 píxeles entre los containers
            Container(
              height: 148.0, // Altura de 148 píxeles
              width: double.infinity, // Ocupa todo el ancho disponible
              color: Colors.blue, // Color de fondo azul
              child: const Center(child: Text('Tercer Container')), // Texto dentro del tercer Container
            ),
            const SizedBox(height: 12.0), // Espacio de 12 píxeles entre los containers
            Container(
              height: 148.0, // Altura de 148 píxeles
              width: double.infinity, // Ocupa todo el ancho disponible
              color: Colors.blue, // Color de fondo azul
              child: const Center(child: Text('Cuarto Container')), // Texto dentro del cuarto Container
            ),
            const SizedBox(height: 12.0), // Espacio de 12 píxeles entre los containers
            
            Container(
              height: 100,
              color: Colors.transparent,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child:Row(
                  children: [
                    Container(
                      width: 100, // Altura de 148 píxeles
                      color: Colors.pink, 
                      margin: const EdgeInsets.only(right: 12.0),
                      child: const Center(child: Text('Container 1'),),
                    ),
                    Container(
                      width: 100, // Altura de 148 píxeles
                      color: Colors.pink, 
                      margin: const EdgeInsets.only(right: 12.0),
                      child: const Center(child: Text('Container 2'),),
                    ),
                    Container(
                      width: 100, // Altura de 148 píxeles
                      color: Colors.pink, 
                      margin: const EdgeInsets.only(right: 12.0),
                      child: const Center(child: Text('Container 3'),),
                    ),
                    Container(
                      width: 100, // Altura de 148 píxeles
                      color: Colors.pink, 
                      margin: const EdgeInsets.only(right: 12.0),
                      child: const Center(child: Text('Container 4'),),
                    ),
                    Container(
                      width: 100, // Altura de 148 píxeles
                      color: Colors.pink, 
                      margin: const EdgeInsets.only(right: 12.0),
                      child: const Center(child: Text('Container 5'),),
                    ),
                    Container(
                      width: 100, // Altura de 148 píxeles
                      color: Colors.pink, 
                      margin: const EdgeInsets.only(right: 12.0),
                      child: const Center(child: Text('Container 6'),),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 14.0),

            Container(
              height: 100,
              color: Colors.transparent,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child:Row(
                  children: [
                    Container(
                      width: 100, // Altura de 148 píxeles
                      color: Colors.green, 
                      margin: const EdgeInsets.only(right: 12.0),
                      child: const Center(child: Text('Container 1'),),
                    ),
                    Container(
                      width: 100, // Altura de 148 píxeles
                      color: Colors.green, 
                      margin: const EdgeInsets.only(right: 12.0),
                      child: const Center(child: Text('Container 2'),),
                    ),
                    Container(
                      width: 100, // Altura de 148 píxeles
                      color: Colors.green, 
                      margin: const EdgeInsets.only(right: 12.0),
                      child: const Center(child: Text('Container 3'),),
                    ),
                    Container(
                      width: 100, // Altura de 148 píxeles
                      color: Colors.green, 
                      margin: const EdgeInsets.only(right: 12.0),
                      child: const Center(child: Text('Container 4'),),
                    ),
                    Container(
                      width: 100, // Altura de 148 píxeles
                      color: Colors.green, 
                      margin: const EdgeInsets.only(right: 12.0),
                      child: const Center(child: Text('Container 5'),),
                    ),
                    Container(
                      width: 100, // Altura de 148 píxeles
                      color: Colors.green, 
                      margin: const EdgeInsets.only(right: 12.0),
                      child: const Center(child: Text('Container 6'),),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 14.0),

            Container(
              height: 220,
              color: Colors.yellow,
              child: const Center(child: Text('Quinto Container'),),
            ),

            const SizedBox(height: 14.0),
            
          ],
        ),
      ),
    );
  }
}