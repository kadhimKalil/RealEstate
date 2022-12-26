import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/layout/cubit/cubit.dart';
import 'package:flutter_app/layout/home_layout.dart';
import 'package:flutter_app/layout/provider/saved_provider.dart';
import 'package:flutter_app/moduls/login/login.dart';
import 'package:flutter_app/shared/components/constant.dart';
import 'package:flutter_app/shared/network/local/cach_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,

  ));

  await Firebase.initializeApp();

  var messaging = FirebaseMessaging.instance.getInitialMessage();

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });

  await CacheHelper.init();

  // if(CacheHelper.getData(key: 'uid') != null){
  //   uid = CacheHelper.getData(key: 'uid');
  // }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => RealEstateCubit()
              ..fetchItems()
              ..getUserData()),
      ],
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => SavedProvider()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              primarySwatch: Colors.indigo,
              primaryColor: HexColor('f5f5f5'),
              fontFamily: 'janna',
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              textTheme: const TextTheme(
                bodyText1: TextStyle(fontSize: 14.0),
              )),
          home: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapShot) {
                if (snapShot.hasData) {
                  uid = FirebaseAuth.instance.currentUser!.uid;
                  print(uid);
                  return HomeLayout();
                } else {
                  return LoginScreen();
                }
              }),
        ),
      ),
    );
  }
}
