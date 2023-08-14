import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ServiPro/provider/user/detail_profile_provider.dart';
import 'package:ServiPro/src/widget/custom_input.dart';

class DetailsPefilView extends StatelessWidget {
  DetailsPefilView({super.key, required this.userProvider, required this.tipo});

  DetailsFormProvider userProvider;
  final String tipo;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return ChangeNotifierProvider(
      create: (_) => DetailsFormProvider(),
      child: Form(
        autovalidateMode: AutovalidateMode.always,
        key: userProvider.formKey,
        child: Wrap(
          children: [
            const Center(
                heightFactor: 2,
                child: Text(
                  'Completar Registro ',
                  style: TextStyle(
                      fontFamily: 'georgia',
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                      decoration: TextDecoration.underline),
                )),
            if (tipo == "F")
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  onChanged: (value) {
                    userProvider.userDatails.servicio = value;
                  },
                  validator: (value) {
                    if (value == '')
                      return 'Se Debe Especificar Tipo Servico';
                    else
                      return null;
                  },
                  decoration: CustomInput.myInputStyles(
                      context: context,
                      hint: 'Profesion o Servicio Ofrece)',
                      label: 'Que haces ',
                      icon: Icons.plumbing),
                ),
              ),
            if (tipo == "F")
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  onChanged: (value) {
                    userProvider.userDatails.detalle_servicio = value;
                  },
                  validator: (value) {
                    if (value == '')
                      return 'Describe Que esta Ofreciento ';
                    else
                      return null;
                  },
                  decoration: CustomInput.myInputStyles(
                      context: context,
                      hint: 'Describe Tu experriencia en el Area',
                      label: 'Describa  Tu experiencias en el Area',
                      icon: Icons.abc),
                ),
              ),
            if (tipo == "F")
              SizedBox(
                width: 150,
                child: Padding(
                  padding: EdgeInsets.all(3.0),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    onChanged: (dynamic entero) => userProvider
                        .userDatails.esperiencia = int.parse(entero),
                    validator: (value) {
                      if (value == '')
                        return 'Cuanto Tiempo Tiene de Experiencia';
                      else
                        return null;
                    },
                    decoration: CustomInput.myInputStyles(
                        context: context,
                        hint: 'Tiempo de 0 a 100',
                        label: 'Tiempo Transcurrido',
                        icon: Icons.timeline),
                  ),
                ),
              ),
            if (tipo == "F")
              Container(
                width: screenSize.width * 0.55,
                padding: const EdgeInsets.all(3.0),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  onChanged: (value) => userProvider.userDatails.tiempo = value,
                  validator: (value) {
                    if (value == '')
                      return 'Describa Tiempo Dia , Semana, Mes o Anos';
                    else
                      return null;
                  },
                  decoration: CustomInput.myInputStyles(
                      context: context,
                      hint: 'Tiempo dia,mes,ano',
                      label: 'Tiempo dia mes ano',
                      icon: Icons.abc_outlined),
                ),
              ),
            Container(
              width: 175,
              padding: EdgeInsets.all(3.0),
              child: TextFormField(
                keyboardType: TextInputType.phone,
                onChanged: (value) => userProvider.userDatails.contacto = value,
                validator: (value) {
                  if (value == '')
                    return 'Whatsapp o Telefono de Contacto';
                  else
                    return null;
                },
                decoration: CustomInput.myInputStyles(
                    context: context,
                    hint: 'Whatsaap',
                    label: 'Telefono',
                    icon: FontAwesomeIcons.whatsapp),
              ),
            ),
            Container(
              width: screenSize.width * 0.48,
              padding: const EdgeInsets.all(3.0),
              child: TextFormField(
                keyboardType: TextInputType.phone,
                onChanged: (value) =>
                    userProvider.userDatails.otro_contacto = value.toString(),
                decoration: CustomInput.myInputStyles(
                    context: context,
                    hint: 'Otro Telefono ',
                    label: 'Otro Telefono',
                    icon: FontAwesomeIcons.telegram),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                onChanged: (value) =>
                    userProvider.userDatails.rede_social = value.toString(),
                decoration: CustomInput.myInputStyles(
                    context: context,
                    hint: 'Redes Sociales',
                    label: 'intagram , facebook, twitter otro',
                    icon: Icons.social_distance_outlined),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextFormField(
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  userProvider.userDatails.ciudad = value;
                },
                validator: (value) {
                  if (value == '')
                    return 'Ciudad O Provincia ';
                  else
                    return null;
                },
                decoration: CustomInput.myInputStyles(
                    context: context,
                    hint: 'Ciudad o Provincia',
                    label: 'Ciudad o Provincia',
                    icon: Icons.location_city_outlined),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextFormField(
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  userProvider.userDatails.sector_barrio = value;
                },
                decoration: CustomInput.myInputStyles(
                    context: context,
                    hint: 'Sector o Barrio',
                    label: 'Sector o  Barrio',
                    icon: Icons.location_city_sharp),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextFormField(
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  userProvider.userDatails.direcion_ubicacion = value;
                },
                validator: (value) {
                  if (value == '')
                    return 'Direccion ';
                  else
                    return null;
                },
                decoration: CustomInput.myInputStyles(
                    context: context,
                    hint: 'Direccion',
                    label: 'Direccion',
                    icon: Icons.streetview),
              ),
            ),
            Container(
              width: 150,
              padding: const EdgeInsets.all(3.0),
              child: DropdownButtonFormField(
                decoration: CustomInput.myInputStyles(
                    context: context,
                    hint: 'Genero',
                    label: 'Genero',
                    icon: FontAwesomeIcons.genderless),

                // icon: Icon(Icons.arrow_circle_down),
                items: const [
                  DropdownMenuItem(child: Text('M'), value: 'M'),
                  DropdownMenuItem(child: Text('F'), value: 'F'),
                  DropdownMenuItem(child: Text('N/A'), value: 'N'),
                ],
                onChanged: (String? value) =>
                    userProvider.userDatails.sexo = value!,
                validator: (value) {
                  if (value == '' || value == null) return 'Debe  Elegir Sexo';

                  return null;
                },
              ),
            ),
            Container(
              width: screenSize.width * 0.55,
              padding: EdgeInsets.all(2.0),
              child: TextFormField(
                keyboardType: TextInputType.number,
                onChanged: (dynamic valor) {
                  userProvider.userDatails.edad = int.parse(valor);
                },
                validator: (valor) {
                  if (valor == '')
                    return 'Edad ';
                  else
                    return null;
                },
                decoration: CustomInput.myInputStyles(
                    context: context,
                    hint: 'Edad',
                    label: 'Edad',
                    icon: Icons.calendar_month),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
