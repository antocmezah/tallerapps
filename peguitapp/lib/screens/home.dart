import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:peguitapp/components/appbar.dart'; // Acuérdate que modular estilos es el nombre MI PROYECTO
import 'package:peguitapp/components/formulario.dart';
import 'package:peguitapp/components/agregarcuenta.dart';

class Mantenedor extends StatefulWidget {
  const Mantenedor({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MantenedorState createState() => _MantenedorState();
}

class _MantenedorState extends State<Mantenedor> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const SearchScreen(),
    const BilleteraScreen(),
    const CallsScreen(),
    const CuentasScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.bolt),
            label: 'Peguita',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.hail),
            label: 'Trabajadores',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet_outlined),
            label: 'Mi Billetera',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _showEditForm(BuildContext context, DocumentSnapshot peguita) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: Theme.of(context).colorScheme.onSurface,
      builder: (context) => FractionallySizedBox(
        heightFactor: 0.9,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: PeguitaScreen(
                  peguita:
                      peguita, // Pasamos el peguita al formulario correctamente
                ),
              ),
              Positioned(
                top: 16,
                right: 16,
                child: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _deletePeguita(BuildContext context, String id) async {
    final confirm = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Eliminar oferta de peguita'),
          content: const Text(
              '¿Estás seguro de que deseas eliminar esta oferta de peguita?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Eliminar'),
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      try {
        await FirebaseFirestore.instance
            .collection('peguitas')
            .doc(id)
            .delete();
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Peguita eliminada exitosamente')),
        );
      } catch (e) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Error al eliminar la oferta de peguita')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: 
      StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('peguitas').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No hay registros disponibles.'));
          }

          final peguitas = snapshot.data!.docs;

          return ListView.separated(
            itemCount: peguitas.length,
            separatorBuilder: (context, index) => const Divider(
              color: Color.fromARGB(255, 235, 235, 235),
              thickness: 1,
            ),
            itemBuilder: (context, index) {
              final peguita = peguitas[index].data() as Map<String, dynamic>;
              final peguitaId = peguitas[index].id;

              return Card(
                margin: const EdgeInsets.all(8.0),
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Column(
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                color: Colors.amber,
                              ),
                            ],
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${peguita['nombre']}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '${peguita['dia']}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '${peguita['pago']}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          )),
                        ],
                      ),

                      // Información del peguita

                      // Botón para editar y eliminar
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            color: Colors.grey[600], // Gris claro
                            onPressed: () {
                              _showEditForm(context, peguitas[index]);
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            color: Colors.grey[600], // Gris claro
                            onPressed: () {
                              _deletePeguita(context, peguitaId);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PeguitaScreen()),
          );
        },
        label: const Text('Publicar'),
        icon: const Icon(Icons.add),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Búsqueda'),
      ),
      body: const Center(
        child: Text('Pantalla de búsqueda'),
      ),
    );
  }
}

class BilleteraScreen extends StatelessWidget {
  const BilleteraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        toolbarHeight: 336.0, // Ajusta la altura del AppBar
        flexibleSpace: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Alinea el contenido a la izquierda
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment:
                    Alignment.centerRight, // Alinea el ícono a la derecha
                child: IconButton(
                  icon: const Icon(Icons.headset_mic),
                  color: Colors.white, // Cambia el color aquí
                  onPressed: () {},
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'En tu cuenta',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0), // Espaciado solo vertical
                decoration: BoxDecoration(
                  color: Theme.of(context)
                      .colorScheme
                      .tertiary, // Color terciario del tema
                  borderRadius:
                      BorderRadius.circular(16.0), // Bordes redondeados
                ),
                child: const Center(
                  child: Text(
                    '\$109.400',
                    style: TextStyle(
                      fontSize: 48.0,
                      color: Colors.white, // Color del texto
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center, // Centra los botones
              children: [
                const SizedBox(width: 16.0),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                        color: Colors.white, // Borde blanco
                      ),
                      foregroundColor: Colors.white, // Texto blanco
                    ),
                    child: const Text('Ingresar Dinero'),
                  ),
                ),
                const SizedBox(width: 8), // Espaciado entre los botones
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CuentasScreen(),
                        ),
                      );
                    },
                    child: const Text('Enviar a cuenta'),
                  ),
                ),
                const SizedBox(width: 16.0),
              ],
            ),
          ],
        ),
      ),
      body: ListView(
        children: const [
          SizedBox(height: 32.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Movimientos',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 24.0),
                Text(
                  '01 de Mayo',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 16.0),

                // Lista de movimientos
                ListTile(
                  leading: Icon(
                    Icons.call_made,
                    color: Colors.green, // Color del ícono leading
                  ),
                  title: Text('Ayuda a Memo'),
                  subtitle: Text('de gomezpatricia'),
                  trailing: Text(
                    '\$30.000', // Valor del movimiento
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Divider(height: 1),

                ListTile(
                  leading: Icon(
                    Icons.call_received,
                    color: Colors.red, // Color del ícono leading
                  ),
                  title: Text('Gasfiter Destapador'),
                  subtitle: Text('para javierpereza'),
                  trailing: Text(
                    '\$35.000', // Valor del movimiento
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),

                SizedBox(height: 24.0),
                Text(
                  '25 de Abril',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 16.0),

                // Lista de movimientos
                ListTile(
                  leading: Icon(
                    Icons.subdirectory_arrow_left,
                    color: Colors.black, // Color del ícono leading
                  ),
                  title: Text('Envio de dinero'),
                  subtitle: Text('Cuenta BCI - Cata'),
                  trailing: Text(
                    '\$8.000', // Valor del movimiento
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Divider(height: 1),

                ListTile(
                  leading: Icon(
                    Icons.call_received,
                    color: Colors.green, // Color del ícono leading
                  ),
                  title: Text('Babysitter Ema'),
                  subtitle: Text('de floricienta'),
                  trailing: Text(
                    '\$10.000', // Valor del movimiento
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),

                SizedBox(height: 24.0),

                Text(
                  '12 de Abril',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 16.0),

                ListTile(
                  leading: Icon(
                    Icons.call_received,
                    color: Colors.red, // Color del ícono leading
                  ),
                  title: Text('Pasear a Puki'),
                  subtitle: Text('para gaby1250_'),
                  trailing: Text(
                    '\$10.000', // Valor del movimiento
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                 Divider(height: 1),

                 ListTile(
                  leading: Icon(
                    Icons.call_received,
                    color: Colors.red, // Color del ícono leading
                  ),
                  title: Text('Cerrajero'),
                  subtitle: Text('para hgonzalez64'),
                  trailing: Text(
                    '\$25.000', // Valor del movimiento
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CallsScreen extends StatelessWidget {
  const CallsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mensaje'),
      ),
      body: const Center(
        child: Text('Pantalla de mensajes'),
      ),
    );
  }
}

class CuentasScreen extends StatelessWidget {
  const CuentasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Elegir cuenta'),
      ),
      body: Column(
        children: [
          // Botón para agregar una nueva cuenta
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity, // Hace que el botón ocupe todo el ancho
              child: FilledButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AgregarCuentaScreen(),
                    ),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                    Theme.of(context).colorScheme.secondary,
                  ),
                  padding: WidgetStateProperty.all(
                    const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 24.0), // Padding interno
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment
                      .spaceBetween, // Alinea los elementos de manera que estén al principio y al final
                  children: [
                    Row(
                      children: [
                        Icon(Icons.person_add_alt), // Icono a la izquierda
                        SizedBox(width: 8),
                        Text('Agregar cuenta'),
                      ],
                    ),
                    Icon(Icons.chevron_right), // Icono a la derecha
                  ],
                ),
              ),
            ),
          ),
          // Encabezado: "Mi Cuenta"
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Align(
              alignment:
                  Alignment.centerLeft, // Justifica el texto a la izquierda
              child: Text(
                'Mis cuentas',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
          // Lista de cuentas obtenidas desde Firestore
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('cuentas').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(child: Text('Error al cargar datos'));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final cuentas = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: cuentas.length,
                  itemBuilder: (context, index) {
                    final cuenta =
                        cuentas[index].data() as Map<String, dynamic>;
                    final nombre = cuenta['nombre'] ?? 'Sin nombre';
                    final numCuenta = cuenta['numcuenta'] ?? 'Sin número';
                    final rut = cuenta['rut'] ?? 'Sin RUT';
                    final banco = cuenta['banco'] ?? 'Sin banco'; // Nuevo campo

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Column(
                          children: [
                            Container(
                              color: Theme.of(context).primaryColor,
                              child: ExpansionTile(
                                collapsedIconColor: Colors.white,
                                iconColor: Colors.white,
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      nombre,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "$banco",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                            color: Colors.white70,
                                          ),
                                    ),
                                  ],
                                ),
                                children: [
                                  Container(
                                    color: Theme.of(context)
                                        .cardColor, // Fondo claro de los detalles
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Padding individual para cada texto
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 16.0,
                                              right: 16.0,
                                              top: 16.0,
                                              bottom: 4.0),
                                          child: Text(
                                            "Cuenta: ${cuenta['categoria'] ?? 'Sin categoría'}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium
                                                ?.copyWith(
                                                    color: Colors.black54),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16.0, vertical: 4.0),
                                          child: Text(
                                            "Nro de cuenta: $numCuenta",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium
                                                ?.copyWith(
                                                    color: Colors.black54),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 16.0,
                                              right: 16.0,
                                              top: 4.0,
                                              bottom: 0),
                                          child: Text(
                                            "RUT: $rut",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium
                                                ?.copyWith(
                                                    color: Colors.black54),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: IconButton(
                                            icon: const Icon(Icons.edit),
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      AgregarCuentaScreen(
                                                    cuenta: cuentas[index],
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
