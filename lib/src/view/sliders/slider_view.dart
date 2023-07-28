import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:services_joined/src/widget/slide_widget/format_slide_widget.dart';



class Nslider extends StatelessWidget {
  const Nslider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PasaSlider(
      sizepuntoPrimario: 15,
      sizepuntoSecundar: 10,
      toppage: false,
      //  : false, //si se muestran arriba
      colorPrimario: Colors.red, //cambiar elcolor de los indicadores
      colorSecundario: Colors.black26, // cambia el bacolor de los indicadores
      lislider: [
        Image.asset('assets/images/no-image.jpg'),
        Image.asset('assets/images/no-image.jpg'),
        Image.asset('assets/images/no-image.jpg'),
        Image.asset('assets/images/no-image.jpg'),
        Image.asset('assets/images/no-image.jpg'),

      ],
    );
  }
}
