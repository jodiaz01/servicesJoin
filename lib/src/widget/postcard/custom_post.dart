import 'package:ServiPro/provider/firebase/crud_fire_post.dart';
import 'package:ServiPro/src/widget/slide_widget/format_slide_widget.dart';
import 'package:flutter/material.dart';
import 'package:ServiPro/src/widget/custon_elevateButton.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class InstagramPostCard extends StatefulWidget {
  final String username;
  final String title;
  final String caption;
  final List imageUrl;
  final Color colorbtn;
  final String? avatar;
  final double? precio;
  final Function()? onTap;
  final String? idocuments;
  final String? clienst;
  // final String estado;
  bool isFollower ;

  InstagramPostCard(
      {required this.username,
      required this.title,
      required this.caption,
      required this.imageUrl,
      required this.colorbtn,
      this.avatar,
      this.precio,
      this.onTap,
      this.idocuments,
      this.clienst,
      //  required this.estado,
      required this.isFollower
      });

  @override
  State<InstagramPostCard> createState() => _InstagramPostCardState();
}

class _InstagramPostCardState extends State<InstagramPostCard> {
  @override
  Widget build(BuildContext context) {
    final postProvider = Provider.of<FirebasePost>(context);

    final screenSize = MediaQuery.of(context).size;
    return   buildCardPostByAlcances(context, postProvider);
  }

  Card buildCardPostByAlcances(BuildContext context, FirebasePost postProvider) {
    return Card(
          color: widget.colorbtn.withOpacity(0.2),
          // height: screenSize.height * .756,
          elevation: 0.0,
          margin: EdgeInsets.only(left: 4),
          // margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Foto del post
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      widget.username,
                      style: GoogleFonts.montserratSubrayada(
                          color: widget.colorbtn),
                    ),
                    widget.precio == 0
                        ? const SizedBox()
                        : Text(
                            'RD\$: ${widget.precio}',
                            style: GoogleFonts.belgrano(color: Colors.green),
                          )
                  ],
                ),
              ),

              Container(
                color: Colors.transparent,
                padding: const EdgeInsets.only(top: 0, left: 1.0, right: 1.2),
                height: MediaQuery.of(context).size.height * 0.6,
                width: MediaQuery.of(context).size.width * 0.5,
                child: PasaSlider(
                    sizepuntoPrimario: 12,
                    sizepuntoSecundar: 10,
                    toppage: false,
                    colorPrimario: widget.colorbtn,
                    colorSecundario: Colors.black26,
                    lislider: widget.imageUrl
                        .map(
                          (e) => ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: e == ''
                                ? const FadeInImage(
                                    fadeInDuration: Duration(seconds: 4),
                                    placeholder:
                                        AssetImage('assets/images/user.png'),
                                    image:
                                        AssetImage('assets/images/user.png'),
                                    width: 100,
                                    height: 100,
                                  )
                                : Stack(
                                    alignment: Alignment.center,
                                    fit: StackFit.passthrough,
                                    children: [
                                      Image.network(
                                        e,
                                        fit: BoxFit.cover,
                                        height: 400,
                                      ),
                                      Positioned(
                                        left: -8,
                                        top: -8,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          child: ClipOval(
                                            child: GestureDetector(
                                              onTap: widget.onTap,
                                              child: Image.network(
                                                widget.avatar.toString(),
                                                fit: BoxFit.fill,
                                                height: 80,
                                                width: 80,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                        )
                        .toList()),
              ),

              // Detalles del post
              Padding(
                padding: const EdgeInsets.all(4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Nombre de usuario
                    Text(
                      widget.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    // Espacio entre el nombre de usuario y el texto del caption
                    const SizedBox(height: 8.0),

                    // Caption del post
                    Text(widget.caption,
                        maxLines: 2, overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),

              // Botones e ícono de desplegable
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Botón de Like
                  CustomElevateButton(
                    color: widget.colorbtn,
                    width: 90,
                    height: 30,
                    function: () {
                      // Lógica del botón Like
                    },
                    icon: const Icon(Icons.thumb_up),
                    text: 'Like',
                  ),

                  // Botón de Seguir
                  if (!widget.isFollower)
                    CustomElevateButton(
                      color: widget.colorbtn,
                      width: 110,
                      height: 30,
                      function: () async {
                        // Lógica del botón Like
                        widget.isFollower = await postProvider.seguirPoster(
                            widget.idocuments, widget.clienst);
                        if (widget.isFollower) {
                          setState(() {
                            widget.isFollower;
                          });
                          return;
                        }
                      },
                      icon: const Icon(Icons.person_add),
                      text: 'sequir',
                    )
                  else
                    SizedBox(),
                  // Botón de Comentario
                  CustomElevateButton(
                    color: widget.colorbtn,
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
              Divider(
                color: Colors.black26,
              )
            ],
          ),
        );
  }
}
