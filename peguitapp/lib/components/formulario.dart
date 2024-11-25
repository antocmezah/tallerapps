import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PeguitaScreen extends StatefulWidget {
  final DocumentSnapshot? peguita;

  const PeguitaScreen({super.key, this.peguita});

  @override
  // ignore: library_private_types_in_public_api
  _PeguitaScreenState createState() => _PeguitaScreenState();
}

class _PeguitaScreenState extends State<PeguitaScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _mostrarImagenes = false;

  // Controladores para los campos de texto
  final _nombreController = TextEditingController();
  final _diaController = TextEditingController();
  final _pagoController = TextEditingController();
  final _descripcionController = TextEditingController();
  final List<String> _secciones = [
    'Cuidado/Asistencia',
    'Educación',
    'Limpieza/Orden',
    'Arreglos',
    'Belleza',
    'Armado',
    'Mascotas',
    'Plantas'
  ];
  String? _seccionSeleccionada;

  @override
  void initState() {
    super.initState();

    // Si estamos en modo edición, cargamos los datos del peguita en los controladores
    if (widget.peguita != null) {
      final peguitaData = widget.peguita!.data() as Map<String, dynamic>;
      _nombreController.text = peguitaData['nombre'] ?? '';
      _diaController.text = peguitaData['dia'] ?? '';
      _pagoController.text = peguitaData['pago'] ?? '';
      _descripcionController.text = peguitaData['descripcion'] ?? '';
      _seccionSeleccionada = peguitaData['seccion'] ?? '';
    }
  }

  @override
  void dispose() {
    // Liberamos los controladores al cerrar el formulario
    _nombreController.dispose();
    _diaController.dispose();
    _pagoController.dispose();
    _descripcionController.dispose();
    super.dispose();
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

  Future<void> _savePeguita() async {
    if (_formKey.currentState!.validate()) {
      final peguitaData = {
        'nombre': _nombreController.text,
        'dia': _diaController.text,
        'pago': _pagoController.text,
        'descripcion': _descripcionController.text,
        'seccion': _seccionSeleccionada,
      };

      try {
        if (widget.peguita == null) {
          // Si el peguita es nuevo, lo agregamos a la colección
          await FirebaseFirestore.instance
              .collection('peguitas')
              .add(peguitaData);

          // Mostrar un SnackBar de confirmación de creación
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Peguita creada correctamente')),
          );
        } else {
          // Si es una edición, actualizamos el documento existente
          await FirebaseFirestore.instance
              .collection('peguitas')
              .doc(widget.peguita!.id)
              .update(peguitaData);

          // Mostrar un SnackBar de confirmación de edición
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Peguita editada correctamente')),
          );
        }

        // ignore: use_build_context_synchronously
        Navigator.of(context).pop(); // Cerramos el formulario
      } catch (e) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error al guardar la peguita')),
        );
      }
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    // Mostrar el selector de fecha
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 60)),
      locale: const Locale('es'),
    );

    if (pickedDate != null) {
      // Formatear la fecha seleccionada a un formato más adecuado
      final formattedDate = "${pickedDate.toLocal()}".split(' ')[0];
      setState(() {
        _diaController.text =
            formattedDate; // Asignar la fecha seleccionada al controlador
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.peguita == null ? 'Nueva Publicación' : 'Editar peguita'),
        automaticallyImplyLeading: false, // Desactiva la flecha de retroceso
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios), // Ícono de cierre (X)
          onPressed: () {
            Navigator.of(context).pop(); // Cierra la pantalla actual
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              SizedBox(
                width: 328,
                height: 116,
                child: FloatingActionButton.extended(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => Dialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const SizedBox(height: 32),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                SizedBox(
                                  height: 100,
                                  child: TextButton(
                                    onPressed: () {
                                      setState(() {
                                        _mostrarImagenes =
                                            !_mostrarImagenes; // Alternar el estado
                                      });
                                    },
                                    style: ButtonStyle(
                                      foregroundColor: WidgetStatePropertyAll(
                                          Theme.of(context)
                                              .colorScheme
                                              .primary),
                                      backgroundColor: WidgetStateProperty.all(
                                          Theme.of(context)
                                              .colorScheme
                                              .surface),
                                      shape: WidgetStatePropertyAll(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                      ),
                                    ),
                                    child: const Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.camera_alt_outlined,
                                            size: 40),
                                        SizedBox(height: 8),
                                        Text('Agregar foto'),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: TextButton(
                                    onPressed: () {
                                      setState(() {
                                        _mostrarImagenes =
                                            !_mostrarImagenes; // Alternar el estado
                                      });
                                    },
                                    style: ButtonStyle(
                                      foregroundColor: WidgetStatePropertyAll(
                                          Theme.of(context)
                                              .colorScheme
                                              .primary),
                                      backgroundColor: WidgetStateProperty.all(
                                          Theme.of(context)
                                              .colorScheme
                                              .surface),
                                      shape: WidgetStatePropertyAll(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                      ),
                                    ),
                                    child: const Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.camera_alt_outlined,
                                            size: 40),
                                        SizedBox(height: 8),
                                        Text('Galería'),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 32),
                          ],
                        ),
                      ),
                    );
                  },
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  backgroundColor: Theme.of(context).colorScheme.surface,
                  foregroundColor: Theme.of(context).colorScheme.primary,
                  label: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add_to_photos),
                      SizedBox(
                        height: 8,
                      ),
                      Text('Agregar fotos'),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: _nombreController,
                decoration:
                    const InputDecoration(labelText: 'Título de Peguita'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un título para la peguita';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16), // Espacio entre campos

              TextFormField(
                controller: _descripcionController,
                decoration: const InputDecoration(
                  labelText: 'Describe la peguita',
                  hintText:
                      '¿Qué hará el peguitero por ti? Describe el lugar y detalles de la peguita',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintStyle: TextStyle(fontWeight: FontWeight.w400),
                ),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese una descripción para la peguita';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              GestureDetector(
                onTap: () => _selectDate(
                    context), // Abre el DatePicker cuando se toca el campo
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: _diaController,
                    decoration: const InputDecoration(
                      labelText: 'Fecha de Peguita',
                      hintText: 'Selecciona la fecha de la peguita',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese la fecha de la peguita';
                      }
                      return null;
                    },
                  ),
                ),
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: _pagoController,
                decoration: const InputDecoration(labelText: 'Pago'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un monto';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 32),

              const Text(
                'Categorías',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 16),

              Wrap(
                spacing: 8.0,
                children: _secciones.map((categoria) {
                  return ChoiceChip(
                    label: Text(categoria),
                    selected: _seccionSeleccionada == categoria,
                    onSelected: (bool selected) {
                      setState(() {
                        _seccionSeleccionada = selected ? categoria : null;
                      });
                    },
                    selectedColor: Theme.of(context).primaryColor,
                    labelStyle: TextStyle(
                      color: _seccionSeleccionada == categoria
                          ? Colors.white
                          : Colors.black,
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 32), // Espacio antes del botón
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 6),
                child: FilledButton(
                  onPressed: _savePeguita,
                  child:
                      Text(widget.peguita == null ? 'Agregar' : 'Actualizar'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
