import 'package:flutter/material.dart';
import 'package:services_joined/src/widget/custon_elevateButton.dart';

class InstagramPostCard extends StatelessWidget {
  final String username;
  final String caption;
  final String imageUrl;
  final Color colorbtn;

  InstagramPostCard(
      {required this.username,
      required this.caption,
      required this.imageUrl,
      required this.colorbtn});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: colorbtn.withOpacity(0.2),
      elevation: 0.0,
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Foto del post
          ClipRRect(
              borderRadius: const BorderRadius.only(topRight: Radius.circular(6), topLeft: Radius.circular(6), bottomRight: Radius.circular(26), bottomLeft: Radius.circular(26)),

              child: Image.network(
                  height:400,
                  imageUrl, fit: BoxFit.cover)),

          // Detalles del post
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Nombre de usuario
                Text(
                  username,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                // Espacio entre el nombre de usuario y el texto del caption
                const SizedBox(height: 8.0),

                // Caption del post
                Text(caption),
              ],
            ),
          ),

          // Botones e ícono de desplegable
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Botón de Like
              CustomElevateButton(
                color: colorbtn,
                width: 90,
                height: 30,
                function: () {
                  // Lógica del botón Like
                },
                icon: const Icon(Icons.thumb_up),
                text: 'Like',
              ),

              // Botón de Seguir
              CustomElevateButton(
                color: colorbtn,
                width: 110,
                height: 30,
                function: () {
                  // Lógica del botón Like
                },
                icon: const Icon(Icons.person_add),
                text: 'sequir',
              ),
              // Botón de Comentario
              CustomElevateButton(
                color: colorbtn,
                width: 120,
                height: 30,
                function: () {
                  // Lógica del botón Like
                },
                icon: const Icon(Icons.comment),
                text: 'cometar',
              ),
              // Dropdown o desplegable "Ver más contenido"
              PopupMenuButton<String>(
                onSelected: (value) {
                  // Lógica para manejar las opciones seleccionadas
                },
                itemBuilder: (BuildContext context) => [
                  const PopupMenuItem(
                    value: 'ver_mas_contenido',
                    child: Text('Ver más contenido'),
                  ),
                  // Aquí puedes agregar más opciones si lo deseas
                ],
              ),
            ],
          ),
          const SizedBox(height: 12,)
        ],
      ),
    );
  }
}
