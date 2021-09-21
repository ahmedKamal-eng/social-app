import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/login/cubit/cubit.dart';
import 'package:social_app/modules/login/social_login_screen.dart';
import 'package:social_app/shop_cubit/cubit.dart';
import 'package:social_app/shop_cubit/states.dart';

import 'obServer.dart';

void main() async {
  //we use this line when we use the async
  //this line ensure all things in the main method is initialized
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  // to execute the observer
  Bloc.observer = MyBlocObserver();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => ShopCubit(),
        child: BlocConsumer<ShopCubit, ShopStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return SocialLoginScreen();
          },
        ),
      ),
    );
  }
}
