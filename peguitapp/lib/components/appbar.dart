import 'package:flutter/material.dart';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Theme.of(context).colorScheme.primary,
    toolbarHeight: 280,
    flexibleSpace: Column(
      children: [
        // Íconos en la parte superior
        Padding(
          padding: const EdgeInsets.only(
              top: 32.0,
              right: 16.0), // Ajusta el padding para que estén bien posicionados
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.end, // Centra los íconos
            children: [
              const Padding(padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0)),
              IconButton(
                icon: const Icon(Icons.notifications_none_rounded, size: 24),
                color: Theme.of(context).colorScheme.surface,
                padding: EdgeInsets.zero,
                onPressed: () {
                  // Acción para el primer ícono
                },
              ),
              IconButton(
                icon: const Icon(Icons.chat_bubble_outline_rounded, size: 24),
                color: Theme.of(context).colorScheme.surface,
                padding: EdgeInsets.zero,
                onPressed: () {
                  // Acción para el segundo ícono
                },
              ),

            ],
          ),
        ),
        // Espacio entre los íconos y la search bar
        const SizedBox(height: 50),
        // La SearchBar
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: SearchBar(
            hintText: '¿Buscas peguita?',
            leading: const Icon(Icons.search,
            color: Colors.white),
            backgroundColor:
                WidgetStatePropertyAll(Theme.of(context).colorScheme.tertiary),
            textStyle: WidgetStatePropertyAll(
              TextStyle(
                color: Theme.of(context).colorScheme.surface,
                fontSize: 19,
                fontWeight: FontWeight.w500,
              ),
            ),
            onChanged: (value) {},
          ),
        ),
      ],
    ),
  );
}
