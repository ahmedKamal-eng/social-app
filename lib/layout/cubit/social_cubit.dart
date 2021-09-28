import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/social_states.dart';
import 'package:social_app/models/social_user_model.dart';
import 'package:social_app/modules/chats/chat_screen.dart';
import 'package:social_app/modules/feeds/feeds_screen.dart';
import 'package:social_app/modules/settings/settings_screen.dart';
import 'package:social_app/modules/users/users_screen.dart';
import 'package:social_app/shared/component/constant.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  SocialUserModel model;

  void getUserData() {
    emit(SocialLoadingGetUserState());

    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      print(value.data());
      model = SocialUserModel.fromJson(value.data());
      emit(SocialGetUserSuccessState());
    }).catchError((e) {
      print(e.toString());
      emit(SocialGetUserErrorState(e.toString()));
    });
  }

  int currentIndex = 0;

  List<Widget> screens = [
    FeedsScreen(),
    ChatScreen(),
    UsersScreen(),
    SettingsScreen()
  ];

  List<String> titles = ['Home', 'Chats', 'Users', 'Settings'];

  void changeBottomNav(int index) {
    if (index == 2) {
      emit(SocialNewPostState());
    } else {
      currentIndex = index;

      emit(SocialChangeBottomNavState());
    }
  }
}
