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
      theme: ThemeData.light().copyWith(
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          foregroundColor: Color.fromARGB(255, 255, 255, 255),
        ),
      ),


      home: Scaffold(
        appBar: AppBar(
          title: const Text('facebook',style: TextStyle(fontWeight:FontWeight.w600, color: Color.fromARGB(255, 27, 69, 255))),
          actions: const [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 7.0),
              child: Icon(Icons.add_circle_outlined, color: Color.fromARGB(255, 12, 12, 12),), //Icono de perfil
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 7.0),
              child: Icon(Icons.search_rounded, color: Color.fromARGB(255, 12, 12, 12),), //Icono de perfil
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 7.0),
              child: Icon(Icons.messenger_rounded,  color: Color.fromARGB(255, 12, 12, 12),), //Icono de perfil
            ),
          ],
        ),


        body: SingleChildScrollView(
          
          child: Column(

            children: [

              Container(
                height: 40.0,
                color: const Color.fromARGB(255, 255, 255, 255),

                child: const Row(

                  children: [
                   Expanded(
                      child: Icon(Icons.home_outlined),
                    ),
                    Expanded(
                      child: Icon(Icons.video_library_outlined),
                    ),
                    Expanded(
                      child: Icon(Icons.people_outline),
                    ),
                    Expanded(
                      child: Icon(Icons.store_outlined),
                    ),
                    Expanded(
                      child: Icon(Icons.notifications_outlined),
                    ),
                     Expanded(
                      child: Icon(Icons.account_circle_outlined),
                    ),
                  ],
                  

                ),
                
              ),

              

              Container(
                height: 40.0,
                color: const Color.fromARGB(255, 2, 251, 255),

                child: Row(

                  children: [
                   Expanded(
                      child: Container(
                        height: 40,
                        color: Colors.yellow,
                        child: const Text('Icon',textAlign: TextAlign.center),
                      ),
                    ), 

                    const SizedBox(width: 12.0),

                    Expanded(
                      child: Container(
                        height: 40,
                        color: Colors.yellow,
                        child: const Text('Search Bar',textAlign: TextAlign.center),
                        ),              
                    ), 

                    const SizedBox(width: 12.0),

                    Expanded(
                      child: Container(
                        height: 40,
                        color: Colors.yellow,
                        child: const Text('Icon',textAlign: TextAlign.center),
                        ),  
                    ), 

                  ],
                  

                ),
                
              ),

              const SizedBox(height: 5.0),

              Container(
                height: 180.0,
                color: const Color.fromARGB(255, 89, 255, 0),

                child: Row(


                  children: [
                   Expanded(
                      child: Container(color: Colors.yellow),
                    ),
                    const SizedBox(width: 12.0),
                    Expanded(
                      child: Container(color: Colors.yellow),
                    ),
                    const SizedBox(width: 12.0),
                    Expanded(
                      child: Container(color: Colors.yellow),
                    ),
                    
                  ],
                  

                ),
                
              ),

              const SizedBox(height: 5.0),

              Container(
              
                color: const Color.fromARGB(255, 255, 183, 0),
                
                child: Column(
                  children:[
                    Row(
                      children: [
                        Expanded(child: Container(color: const Color.fromARGB(255, 250, 44, 113), height: 50,))
                      ]
                    ),
                    Row(
                      children: [
                        Expanded(child: Container(color: const Color.fromARGB(255, 252, 104, 247), height: 80,))
                      ]
                    ),

                    Row(
                      children: [
                        Expanded(child: SizedBox(
                          height: 350,
                          child: GridView.count(
                            crossAxisCount: 2,
                            crossAxisSpacing: 5.0,
                            mainAxisSpacing: 5.0,
                            physics: const NeverScrollableScrollPhysics(),
                            children: List.generate(4, (index) {
                              return Container(
                                color: Colors.blue,
                                alignment: Alignment.center,
                                child: Text('Item $index'),
                              );
                            }
                            )
                           ),
                          )
                        )
                      ],
                    ),

                    Row(
                      children: [
                        Expanded(child: Container(color: const Color.fromARGB(255, 252, 104, 247), height: 30,))
                      ]
                    ),
                  ]
                ),

              
                
              ),

              
              
              
            ],
          ), 


        ), 


      ),


    );


  }
}
