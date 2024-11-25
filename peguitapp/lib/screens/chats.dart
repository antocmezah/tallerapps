import 'package:flutter/material.dart';


class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ChatsScreenState createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  int _currentIndex = 0;

  // Catidad de pantallas que se desean, un array con todas las pantallas
  final List<Widget> _screens = [
    const ChatsListScreen(), // Pantalla de chats
    const UpdateScreen(), // Pantalla de actualizaciones
    const CommunityScreen(), // Pantalla de comunidad
    const CallsScreen(), // Pantalla de llamadas
  ];

  // Función para cambiar la pantalla cuando el  toca un icono, más abajo está setState()
  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex], // Muestra la pantalla seleccionada
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex, // Índice actual de la barra de navegación
        onTap: _onItemTapped, // Llama a la función cuando se selecciona una pestaña
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Followers',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.update),
            label: 'Update',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Comunidad',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.call),
            label: 'Llamadas',
          ),
        ],
      ),
    );
  }
}

// Pantalla para mostrar la lista de chats
class ChatsListScreen extends StatelessWidget {
  const ChatsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: const Text('Followers',style: TextStyle(fontWeight:FontWeight.w600,  color: Color.fromARGB(255, 12, 12, 12), fontSize: 18)),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: (){

            },
          ),
      ),

      body: ListView(
          
          children: [


            for (var i = 1; i<=20; i++)
            ListTile(

            
              
            leading: const CircleAvatar(
              backgroundImage: AssetImage('lib/assets/images/PROFILE.jpg'),
              radius: 25,
            ),
            

            title: Text('Nombre $i',
            style: const TextStyle(
                fontWeight: FontWeight.w500, 
                color: Color.fromARGB(255, 12, 12, 12), 
                fontSize: 14,
                fontFamily: 'roboto',
              ),
            ),

            subtitle:Text('$i', 
            style: const TextStyle(
                fontWeight: FontWeight.w400, 
                color: Color.fromARGB(255, 12, 12, 12), 
                fontSize: 10.5,
                fontFamily: 'roboto',

              ),
            ) ,
            

            trailing: Wrap(
              spacing: 10,
              crossAxisAlignment: WrapCrossAlignment.center, 

              children: <Widget>[
              
              SizedBox(
                width: 82,
                height: 24,

                child: ElevatedButton(
                  

                  onPressed: (){ 

                  },
                
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(110, 10),
                  elevation: 0,
                  backgroundColor: const Color.fromARGB(255, 236, 234, 234),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  padding: EdgeInsets.zero,    
                ),
                
                child: const Text(
                  'Siguiendo', 
                  style: TextStyle(
                    fontFamily: 'roboto',
                    fontWeight: FontWeight.w400, 
                    color: Color.fromARGB(255, 12, 12, 12), 
                    fontSize: 13,
                  ),
                ),

              ),
              ),

              
              
              
              const Icon(
                Icons.notifications_outlined,
                ),

              ]
            )
            
          ),

           
        ],
      ), 
    );
  }
}

// Pantalla para actualizaciones
class UpdateScreen extends StatelessWidget {
  const UpdateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Actualizaciones',style: TextStyle(fontWeight:FontWeight.w600,  color: Color.fromARGB(255, 12, 12, 12), fontSize: 18)),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: (){

            },
          ),
      ),
      body:const Center(child:Text('Update'),)
    );
  }
}

// Pantalla para comunidad
class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Comunidad',style: TextStyle(fontWeight:FontWeight.w600,  color: Color.fromARGB(255, 12, 12, 12), fontSize: 18)),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: (){

            },
          ),
      ),
      body:const Center(child:Text('Comunidad'),)
    );
  }
}

// Pantalla para llamadass
class CallsScreen extends StatelessWidget {
  const CallsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Calls',style: TextStyle(fontWeight:FontWeight.w600,  color: Color.fromARGB(255, 12, 12, 12), fontSize: 18)),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: (){

            },
          ),
      ),
      body:const Center(child:Text('Llamadas'),)
    );
  }
}
