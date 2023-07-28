
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:services_joined/provider/firebase/crud_fire_user.dart';
import 'package:services_joined/provider/theme/theme.dart';
import 'package:services_joined/provider/user/login_user.dart';
import 'package:services_joined/router/routes.dart';
import 'package:services_joined/src/utils/appcolor.dart';
import 'package:services_joined/src/utils/navigateservice.dart';
import 'package:services_joined/src/widget/custom_input.dart';
import 'package:services_joined/src/widget/customappbar.dart';
import 'package:services_joined/src/widget/custon_elevateButton.dart';
import 'package:services_joined/src/widget/team_creator.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeprovider = Provider.of<ThemeSetting>(context);
    final fireProvider = Provider.of<FirebaseProvider>(context);
    final sizeScreen= MediaQuery.of(context).size;
    return ChangeNotifierProvider(
        create: (_) => LoginFormProvider(),
        child: Builder(builder: (context) {
          final provider =
              Provider.of<LoginFormProvider>(context, listen: false);
          return Scaffold(
            backgroundColor: themeprovider.currentTheme.primaryColor,
            body: CustomAppbar(
                elevation: 0.25,
                // title: Text("Login"),
                icon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:  CustomPaint(
                    size: const Size(140, 140),
                    painter: TeamLogoPainter(
                        'SJ', themeprovider.currentTheme.secondaryHeaderColor.withOpacity(0.6)),
                  ),
                ),
                child: Form(
                  autovalidateMode: AutovalidateMode.always,
                  key: provider.formkey,
                  child: Wrap(
                    children: [
                      const Center(
                          heightFactor: 3,
                          child: Text(
                            'Inicio Sesion',
                            style: TextStyle(
                                fontFamily: 'georgia',
                                fontWeight: FontWeight.w700,
                                fontSize: 24,
                                decoration: TextDecoration.underline),
                          )),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) => provider.email = value,
                          validator: (value) {
                            if (value == '') {
                              return 'El Usuario es obligatorio';
                            } else {
                              return null;
                            }
                          },
                          decoration: CustomInput.myInputStyles(
                              context: context,
                              hint: 'ingrese usuario',
                              label: 'Usuario O Email',
                              icon: Icons.email_outlined),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          onChanged: (value) => provider.password = value,
                          validator: (value) {
                            if (value == '') {
                              return 'la contrasena es  obligatorio';
                            } else {
                              return null;
                            }
                          },
                          decoration: CustomInput.myInputStyles(
                              context: context,
                              hint: 'contrasena',
                              label: 'contrasena',
                              icon: Icons.key),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, left: 16, right: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MaterialButton(
                              onPressed: () async {
                                final isvalid = provider.validateForm();
                                if (isvalid) {
                                  await fireProvider.IniSeccion(provider, context, themeprovider.currentTheme.primaryColor, false);
                                }

                                // then(
                                //         (data) {
                                //
                                //     },
                                //     onError: (e) => print("Error completing: $e"),
                                //   );
                                // NavigationService.replaceTo(ServiceRouter.home);
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              textColor: Colors.white70,
                              color: themeprovider.currentTheme.primaryColor,
                              child: const Text('Login'),
                            ),
                            Expanded(
                                child: Container(
                              width: double.maxFinite,
                              height: 1,
                              color: themeprovider.currentTheme.primaryColor
                                  .withOpacity(0.5),
                            )),
                            const Text("  O  ",
                                style: TextStyle(
                                    color: AppColors.grayColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold)),
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

                                NavigationService.replaceTo(
                                    ServiceRouter.register);
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              textColor: Colors.white70,
                              color: themeprovider.currentTheme.primaryColor,
                              child: const Text('Registrate'),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.symmetric(vertical: 20, horizontal: sizeScreen.width *0.3),
                        child: CustomElevateButton(
                          text: "Usar Mi Huella Digital",
                            function: ()async{
                              bool isCorret = await fireProvider.authenticateAndSave();
                              if(isCorret) {
                                await fireProvider.IniSeccion(provider, (context), themeprovider.currentTheme.primaryColor, isCorret);
                              }

                            },
                            color: themeprovider.currentTheme.primaryColor,
                            width:sizeScreen.width -200,
                            height: 60,
                            icon: Icon(Icons.fingerprint_outlined, size: 32,)),
                      )
                    ],
                  ),
                )),
          );
        }));
  }
}
