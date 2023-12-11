import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';

import 'firebase_options.dart';

class FirebaseController{

  static Future<String> init() async{
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform
    );

//    _connectDefaultDatabase();
    _configureProviders();

    return "Success";
  }

  static _connectDefaultDatabase() async{
    DatabaseReference ref = FirebaseDatabase.instance.ref();
    /*ref.set({
      "name": "Testö",
      "age": 18
    });*/
  }

  static _configureProviders(){
    FirebaseUIAuth.configureProviders([
      EmailAuthProvider(),
      //GoogleProvider(clientId: '342782608941-9m78kdhl14t1pbrhl0lqtfgvtmov0jkv.apps.googleusercontent.com'),
    ]);
  }
}