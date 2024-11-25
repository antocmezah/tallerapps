import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class AgregarCuentaScreen extends StatefulWidget {
  final DocumentSnapshot? cuenta;

  const AgregarCuentaScreen({super.key, this.cuenta});

  @override
  _AgregarCuentaScreenState createState() => _AgregarCuentaScreenState();
}

class _AgregarCuentaScreenState extends State<AgregarCuentaScreen> {
  final _formKey = GlobalKey<FormState>();
  final _rutController = TextEditingController();
  final _nombreController = TextEditingController();
  final _correoController = TextEditingController();
  final _numCuentaController = TextEditingController();

  final List<String> _categorias = [
    'Corriente', 'Vista', 'Ahorro', 'Chequera electrónica'
  ];
  String? _categoriaSeleccionada;

  final List<String> _bancos = [
    'Banco de Crédito e Inversión', 'Banco de Chile', 'Banco Estado',
    'Banco Santander', 'Banco Scotiabank'
  ];
  String? _bancoSeleccionado;

  @override
  void initState() {
    super.initState();
    if (widget.cuenta != null) {
      final cuentaData = widget.cuenta!.data() as Map<String, dynamic>;
      _rutController.text = cuentaData['rut'] ?? '';
      _nombreController.text = cuentaData['nombre'] ?? '';
      _correoController.text = cuentaData['correo'] ?? '';
      _numCuentaController.text = cuentaData['numcuenta'] ?? '';
      _categoriaSeleccionada = cuentaData['categoria'] ?? '';
      _bancoSeleccionado = cuentaData['banco'] ?? '';
    }
  }

  @override
  void dispose() {
    _rutController.dispose();
    _nombreController.dispose();
    _correoController.dispose();
    _numCuentaController.dispose();
    super.dispose();
  }

  Future<void> _guardarCuenta() async {
    if (_formKey.currentState!.validate()) {
      final cuentaData = {
        'rut': _rutController.text,
        'nombre': _nombreController.text,
        'correo': _correoController.text,
        'numcuenta': _numCuentaController.text,
        'categoria': _categoriaSeleccionada,
        'banco': _bancoSeleccionado,
      };

      try {
        if (widget.cuenta == null) {
          await FirebaseFirestore.instance
              .collection('cuentas')
              .add(cuentaData);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Cuenta creada correctamente')),
          );
        } else {
          await FirebaseFirestore.instance
              .collection('cuentas')
              .doc(widget.cuenta!.id)
              .update(cuentaData);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Cuenta actualizada correctamente')),
          );
        }
        Navigator.of(context).pop();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error al guardar la cuenta')),
        );
      }
    }
  }

  Future<void> _eliminarCuenta() async {
    final confirmation = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirmar eliminación'),
          content: const Text(
              '¿Está seguro de que desea eliminar esta cuenta? Esta acción no se puede deshacer.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Eliminar'),
            ),
          ],
        );
      },
    );

    if (confirmation == true) {
      try {
        await FirebaseFirestore.instance
            .collection('cuentas')
            .doc(widget.cuenta!.id)
            .delete();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Cuenta eliminada correctamente')),
        );
        Navigator.of(context).pop();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error al eliminar la cuenta')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.cuenta == null ? 'Agregar cuenta' : 'Editar cuenta'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    TextFormField(
                      controller: _rutController,
                      decoration: const InputDecoration(labelText: 'RUT'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingrese un RUT';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _nombreController,
                      decoration: const InputDecoration(labelText: 'Nombre'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingrese un nombre';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _correoController,
                      decoration: const InputDecoration(
                      labelText: 'Correo electrónico'),
                      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9@_.-]'))],    
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingrese un correo válido';
                        }
                        return null;
                      },
                      
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: _bancoSeleccionado,
                      items: _bancos.map((banco) {
                        return DropdownMenuItem<String>(
                          value: banco,
                          child: Text(banco),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _bancoSeleccionado = value;
                        });
                      },
                      decoration: const InputDecoration(
                        labelText: 'Selecciona el banco',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor seleccione un banco';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Categorías',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8.0,
                      children: _categorias.map((categoria) {
                        return ChoiceChip(
                          label: Text(categoria),
                          selected: _categoriaSeleccionada == categoria,
                          onSelected: (bool selected) {
                            setState(() {
                              _categoriaSeleccionada =
                                  selected ? categoria : null;
                            });
                          },
                          selectedColor: Theme.of(context).primaryColor,
                          labelStyle: TextStyle(
                            color: _categoriaSeleccionada == categoria
                                ? Colors.white
                                : Colors.black,
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _numCuentaController,
                      decoration:
                          const InputDecoration(labelText: 'Número de cuenta'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingrese un número de cuenta';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            if (widget.cuenta != null) // Mostrar el botón de eliminar solo si estamos editando
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 6),
                  child: OutlinedButton(
                    onPressed: _eliminarCuenta,
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                        color: Colors.red, // Borde blanco
                      ),
                      foregroundColor: Colors.red, // Texto blanco
                    ),
                    child: const Text('Eliminar'),
                  ),
                ),
              ),
            // Botón de "Actualizar" o "Continuar"
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 6),
                child: FilledButton(
                  onPressed: _guardarCuenta,
                  child: Text(
                    widget.cuenta == null ? 'Continuar' : 'Actualizar',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
