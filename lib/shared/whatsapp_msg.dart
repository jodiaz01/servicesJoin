import 'package:elegant_notification/elegant_notification.dart';
import 'package:elegant_notification/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> sendWhatMessage(String phoneNumber) async {
  final urlWhatsapp = "whatsapp://send?phone=$phoneNumber";
  final urlWhatsappWeb = "https://wa.me/$phoneNumber";

  if (await launchUrl(Uri.parse(urlWhatsapp))) {
    await launchUrl(
      Uri.parse(urlWhatsapp),
    );
  } else {
    ElegantNotification.error(
        animation: AnimationType.fromTop,
        notificationPosition: NotificationPosition.center,
        toastDuration: Duration(seconds: 4),
        title: Text("Error"),
        description: Text("El Numero Ya No Dispone de Whatsapp "));
    // throw 'No se pudo abrir la aplicación de WhatsApp';
  }
}
