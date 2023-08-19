import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ServiPro/provider/firebase/crud_fire_user.dart';
import 'package:ServiPro/provider/theme/theme.dart';
import 'package:ServiPro/provider/user/register_provider.dart';
import 'package:ServiPro/router/routes.dart';
import 'package:ServiPro/src/utils/appcolor.dart';
import 'package:ServiPro/src/utils/navigateservice.dart';
import 'package:ServiPro/src/widget/alertas.dart';
import 'package:ServiPro/src/widget/custom_input.dart';
import 'package:ServiPro/src/widget/customappbar.dart';
import 'package:ServiPro/src/widget/custon_elevateButton.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RegisterFormProvider(),
      child: FormRegistro(),
    );
  }
}

class FormRegistro extends StatelessWidget {
  // const FormRegistro({super.key});

  @override
  Widget build(BuildContext context) {
    final themeprovider = Provider.of<ThemeSetting>(context);
    final userProvider = Provider.of<RegisterFormProvider>(context);
    final fireProvider = Provider.of<FirebaseProvider>(context);

    return Scaffold(
      backgroundColor: themeprovider.currentTheme.primaryColor,
      body: CustomAppbar(
          elevation: 0.1,
          // title: Text("Login"),
          icon: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.supervised_user_circle_outlined,
              color: Colors.white,
              size: 80,
            ),
          ),
          child: Form(
            autovalidateMode: AutovalidateMode.always,
            key: userProvider.formkey,
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Wrap(
                children: [
                  Center(
                      heightFactor: 3,
                      child: Text(
                        'Create una Cuenta',
                        style: TextStyle(
                            color: themeprovider.currentTheme.primaryColor ==
                                    Colors.black
                                ? Colors.white.withOpacity(0.7)
                                : themeprovider.currentTheme.primaryColor,
                            fontFamily: 'georgia',
                            fontWeight: FontWeight.w700,
                            fontSize: 24,
                            decoration: TextDecoration.underline),
                      )),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButtonFormField(
                      style: const TextStyle(
                        color: Colors.green,
                      ),
                      decoration: CustomInput.myInputStyles(
                          context: context,
                          hint: 'Cuenta',
                          label: 'Cuenta',
                          icon: Icons.admin_panel_settings_outlined),

                      // icon: Icon(Icons.arrow_circle_down),
                      items: const [
                        DropdownMenuItem(
                            value: 'U',
                            child: Text(
                              'Usuario',
                            )),
                        DropdownMenuItem(
                            value: 'F',
                            child: Text(
                              'Facilitador',
                            )),
                      ],
                      onChanged: (String? value) =>
                          userProvider.usuarios.tipo = value!,
                      validator: (value) {
                        if (value == '' || value == null)
                          return 'Debe  Elegir Tipo Cuenta';

                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      style: buildTextStyle(themeprovider),
                      keyboardType: TextInputType.text,
                      onChanged: (value) {
                        userProvider.usuarios.username = value;
                      },
                      validator: (value) {
                        if (value == '')
                          return 'El Usuario es obligatorio';
                        else
                          return null;
                      },
                      decoration: CustomInput.myInputStyles(
                          context: context,
                          hint: ' usuario',
                          label: 'Usuario',
                          icon: Icons.supervised_user_circle_outlined),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      style: buildTextStyle(themeprovider),
                      keyboardType: TextInputType.text,
                      onChanged: (value) {
                        userProvider.usuarios.firstName = value;
                      },
                      validator: (value) {
                        if (value == '')
                          return 'El Nombre es Obligatorio';
                        else
                          return null;
                      },
                      decoration: CustomInput.myInputStyles(
                          context: context,
                          hint: 'ingrese nombre',
                          label: 'Nombre',
                          icon: Icons.abc),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      style: buildTextStyle(themeprovider),
                      keyboardType: TextInputType.text,
                      onChanged: (value) =>
                          userProvider.usuarios.lastName = value,
                      validator: (value) {
                        if (value == '')
                          return 'El Apellido es obligatorio';
                        else
                          return null;
                      },
                      decoration: CustomInput.myInputStyles(
                          context: context,
                          hint: 'Apellidos',
                          label: 'Apellidos',
                          icon: Icons.abc_outlined),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      style: buildTextStyle(themeprovider),
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) =>
                          userProvider.usuarios.email = value.toString(),
                      validator: (value) {
                        if (value == '')
                          return 'el correo es  obligatorio';
                        else
                          return null;
                      },
                      decoration: CustomInput.myInputStyles(
                          context: context,
                          hint: 'Email',
                          label: 'Correo',
                          icon: Icons.email_outlined),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      style: buildTextStyle(themeprovider),
                      keyboardType: TextInputType.visiblePassword,
                      onChanged: (value) =>
                          userProvider.usuarios.password = value.toString(),
                      obscureText: true,
                      validator: (value) {
                        if (value == '')
                          return 'la contrasena es  obligatorio';
                        else
                          return null;
                      },
                      decoration: CustomInput.myInputStyles(
                          context: context,
                          hint: 'contrasena',
                          label: 'contrasena',
                          icon: Icons.key),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: CustomElevateButton(
                          width: MediaQuery.of(context).size.width - 200,
                          height: 70,
                          color: Colors.blue,
                          icon: const Icon(
                            Icons.fingerprint,
                            size: 48,
                          ),
                          text: 'Huella Digital',
                          function: () async {
                            bool isok = false;
                            isok = await fireProvider.authenticateAndSave();
                            userProvider.usuarios.biometric = isok;
                          },
                        ),
                      )),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 8.0, left: 16, right: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MaterialButton(
                          onPressed: () async {
                            bool isfmvalid = userProvider.validateForm();
                            if (isfmvalid) {
                              userProvider.creado =
                                  await fireProvider.registerUser(
                                      userProvider.usuarios, (context));

                              if (userProvider.creado) {
                                await CustomAlert(
                                    (context),
                                    "Registro Creado",
                                    Text(
                                        "SU USUARIO ES => : ${userProvider.usuarios.username} "),
                                    ServiceRouter.login,
                                    true);
                              }
                            }
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          textColor: Colors.white70,
                          color: themeprovider.currentTheme.primaryColor,
                          child: const Text('Crear'),
                        ),
                        Expanded(
                            child: Container(
                          width: double.maxFinite,
                          height: 1,
                          color: themeprovider.currentTheme.primaryColor
                              .withOpacity(0.5),
                        )),
                        const Text("  Or  ",
                            style: TextStyle(
                                color: AppColors.grayColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w400)),
                        Expanded(
                            child: Container(
                          width: double.maxFinite,
                          height: 1,
                          color: themeprovider.currentTheme.primaryColor
                              .withOpacity(0.5),
                        )),
                        // Icon(FontAwesomeIcons.leftRight),
                        // SizedBox(child: Text(' __________O__________ '),),
                        MaterialButton(
                          onPressed: () async {
                            // await Conexion.db;

                            NavigationService.replaceTo(ServiceRouter.login);
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          textColor: Colors.white70,
                          color: themeprovider.currentTheme.primaryColor,
                          child: const Text('Inicia Sesion'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  TextStyle buildTextStyle(ThemeSetting themeprovider) => TextStyle(
      color: themeprovider.currentTheme.primaryColor == Colors.black
          ? Colors.white.withOpacity(0.7)
          : themeprovider.currentTheme.primaryColor);
}
