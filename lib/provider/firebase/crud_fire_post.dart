
import 'package:flutter/cupertino.dart';

class FirebasePost extends ChangeNotifier{

  FirebasePost(){
    iniciaData();
  }

  iniciaData() async {


    notifyListeners();
  }

}