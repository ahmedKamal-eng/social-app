import 'dart:io';

import 'package:image_picker/image_picker.dart';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/social_states.dart';
import 'package:social_app/models/social_user_model.dart';
import 'package:social_app/modules/chats/chat_screen.dart';
import 'package:social_app/modules/feeds/feeds_screen.dart';
import 'package:social_app/modules/new_post/new_post_screen.dart';
import 'package:social_app/modules/settings/settings_screen.dart';
import 'package:social_app/modules/users/users_screen.dart';
import 'package:social_app/shared/component/constant.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  SocialUserModel userModel;

  void getUserData() {
    emit(SocialLoadingGetUserState());

    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      print(value.data());
      userModel = SocialUserModel.fromJson(value.data());
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
    NewPostScreen(),
    UsersScreen(),
    SettingsScreen()
  ];

  List<String> titles = ['Home', 'Chats', 'Post', 'Users', 'Settings'];

  void changeBottomNav(int index) {
    if (index == 2) {
      emit(SocialNewPostState());
    } else {
      currentIndex = index;

      emit(SocialChangeBottomNavState());
    }
  }

  // get image from gallery using image picker package
  // get profile
  File profileImage; // when using file import dart:io not html
  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(SocialProfileImagePickedSuccessState());
    } else {
      print('No image selected');
      emit(SocialProfileImagePickedErrorState());
    }
  }

  File coverImage;

  // get cover
  Future<void> getCoverImage() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SocialCoverImageSuccessState());
    } else {
      print('No image selected');
      emit(SocialCoverImageErrorState());
    }
  }

  String profileImageUrl = '';

  // the function blew upload profile image to firebase storage
  void uploadProfileImage({
    @required String name,
    @required String phone,
    @required String bio,
  }) {
    emit(SocialUpdateProfileLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child(
            'users/${Uri.file(profileImage.path).pathSegments.last}') //create users folder and put image in it
        .putFile(profileImage) //put profile in users
        .then((value) {
      emit(SocialUploadProfileSuccessState());
      value.ref.getDownloadURL().then((value) {
        profileImageUrl = value;
        print(value);
        updateUser(name: name, phone: phone, bio: bio, image: value);
      }).catchError((e) {
        emit(SocialUploadProfileErrorState());
      });
    }).catchError((e) {
      emit(SocialUploadProfileErrorState());
    });
  }

  String coverImageUrl = '';

  // the function blew upload cover image to firebase storage
  void uploadCoverImage({
    @required String name,
    @required String phone,
    @required String bio,
  }) {
    emit(SocialUpdateProfileLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child(
            'users/${Uri.file(coverImage.path).pathSegments.last}') //create users folder and put image in it
        .putFile(coverImage) //put cover in users
        .then((value) {
      emit(SocialUploadCoverSuccessState());
      value.ref.getDownloadURL().then((value) {
        coverImageUrl = value;
        print(value);
        updateUser(name: name, phone: phone, bio: bio, cover: value);
      }).catchError((e) {
        emit(SocialUploadCoverErrorState());
      });
    }).catchError((e) {
      emit(SocialUploadCoverErrorState());
    });
  }

  // void updateUserImages(
  //     {@required String name, @required String phone, @required String bio}) {
  //   emit(SocialUpdateProfileLoadingState());
  //   if (coverImage != null) {
  //     uploadCoverImage();
  //   } else if (profileImage != null) {
  //     uploadProfileImage();
  //   } else {
  //     updateUser(name: name, phone: phone, bio: bio);
  //   }
  // }

  void updateUser(
      {@required String name,
      @required String phone,
      @required String bio,
      String cover,
      String image}) {
    SocialUserModel model = SocialUserModel(
        name: name,
        phone: phone,
        bio: bio,
        email: userModel.email,
        cover: cover ?? userModel.cover,
        image: image ?? userModel.image,
        uId: userModel.uId,
        isEmailVerified: false);

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError(() {
      emit(SocialUpdateProfileErrorState());
    });
  }
}
