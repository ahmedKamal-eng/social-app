import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/login_model.dart';
import 'package:social_app/models/social_user_model.dart';
import 'package:social_app/modules/register/cubit/states.dart';
import 'package:social_app/shared/network/remote/dio_helper.dart';
import 'package:social_app/shared/network/remote/end_points.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  ShopLoginModel loginModel;

  void userRegister({
    @required String email,
    @required String password,
    @required String name,
    @required String phone,
  }) {
    emit(SocialRegisterLoadingState());

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      userCreate(email: email, uId: value.user.uid, name: name, phone: phone);

      print(value.user.email);
      print(value.user.getIdToken());
    }).catchError((e) {
      print(e.toString());

      emit(SocialRegisterErrorState(e.toString()));
    });
  }

  void userCreate({
    @required String email,
    @required String uId,
    @required String name,
    @required String phone,
  }) {
    SocialUserModel model = SocialUserModel(
        name: name,
        email: email,
        uId: uId,
        phone: phone,
        isEmailVerified: false);

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(SocialCreateUserSuccessState());
    }).catchError((e) {
      print(e.toString());
      emit(SocialCreateUserErrorState(e.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changeIconVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(SocialRegisterPasswordVisibilityState());
  }
}
