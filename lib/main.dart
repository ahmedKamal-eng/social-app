import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/login/cubit/cubit.dart';
import 'package:social_app/modules/login/social_login_screen.dart';
import 'package:social_app/shared/component/constant.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';
import 'package:social_app/shared/styles/themes.dart';
import 'package:social_app/shop_cubit/cubit.dart';
import 'package:social_app/shop_cubit/states.dart';

import 'layout/cubit/social_cubit.dart';
import 'layout/home_layout.dart';
import 'obServer.dart';

void main() async {
  //we use this line when we use the async
  //this line ensure all things in the main method is initialized
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await CacheHelper.init();
  uId = CacheHelper.getData(key: 'uId');

  Widget widget;

  if (uId != null) {
    widget = HomeLayout();
  } else {
    widget = SocialLoginScreen();
  }

  // to execute the observer
  Bloc.observer = MyBlocObserver();

  runApp(MyApp(widget));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  MyApp(this.startWidget);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ShopCubit(),
          ),
          BlocProvider(
            create: (context) => SocialCubit()
              ..getUserData()
              ..getPosts(),
          ),
        ],
        child: BlocConsumer<ShopCubit, ShopStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              home: startWidget,
            );
          },
        ));

    //   MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   home: BlocProvider(
    //     create: (context) => ShopCubit(),
    //     child: BlocConsumer<ShopCubit, ShopStates>(
    //       listener: (context, state) {},
    //       builder: (context, state) {
    //         return StartWidget;
    //       },
    //     ),
    //   ),
    // );
  }
}
