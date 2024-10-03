import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,


      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 249, 255, 78),
          leading:const Icon(Icons.arrow_back_ios, color: Color.fromARGB(255, 12, 12, 12)),
          centerTitle: true,
          title: const Text('Ingresar envío',style: TextStyle(fontWeight:FontWeight.w600,  color: Color.fromARGB(255, 12, 12, 12), fontSize: 22, fontFamily:'Roboto')),
          actions: const [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 7.0),
              child: Icon(Icons.check,  color: Color.fromARGB(255, 12, 12, 12),), //Icono de perfil
            ),
          ],
        ),


        body: ListView(
          children: [

            const SizedBox(height: 30),

            const Center(
              child: Text('¿QUÉ ENVÍAS?', style: TextStyle(fontWeight:FontWeight.w600, fontSize: 16),),
            ),
            
            const SizedBox(height: 10),

            Container(
              color: const Color.fromARGB(255, 220, 220, 220),
              height: 50,
            ),

            const SizedBox(height: 20),

            Container(
              height: 50,
              color: Colors.transparent,
              child: Row(
                children: [

                  Expanded(child: 
                  Container( color: Colors.orange),
                  ),

                  const SizedBox(width:10),

                  Expanded(child: 
                  Container( color: Colors.orange),
                  ),

                  const SizedBox(width:10),

                  Expanded(child: 
                  Container( color: Colors.orange),
                  ),

                  const SizedBox(width:10),

                  Expanded(child: 
                  Container( color: Colors.orange),
                  ),

                ],
              ),
                
              ),

            const SizedBox(height: 20),
           
           Container(
              color: const Color.fromARGB(255, 220, 220, 220),
              height: 50,
            ),

            const SizedBox(height: 20),
           
           Container(
              color: const Color.fromARGB(255, 220, 220, 220),
              height: 50,
            ),

            const SizedBox(height: 30),

              const Center(
              child: Text('¿A QUIÉN ENVÍAS?', style: TextStyle(fontWeight:FontWeight.w600, fontSize: 16),),
            ),
            
            const SizedBox(height: 10),

            Container(
              color: const Color.fromARGB(255, 220, 220, 220),
              height: 50,
            ),

            const SizedBox(height: 10),

            Container(
              color: const Color.fromARGB(255, 220, 220, 220),
              height: 50,
            ),

            const SizedBox(height: 10),

            Container(
              color: const Color.fromARGB(255, 220, 220, 220),
              height: 50,
            ),

            const SizedBox(height: 10),

            Container(
              color: const Color.fromARGB(255, 220, 220, 220),
              height: 50,
            ),

            const SizedBox(height: 10),

            Container(
              color: Colors.amber,
              height: 200,
            ),

          ],
        ), 
      ),
    );

  }
}
