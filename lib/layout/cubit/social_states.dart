import 'package:social_app/modules/chat_details/chat_details_screen.dart';

abstract class SocialStates {}

class SocialInitialState extends SocialStates {}

// get user states
class SocialLoadingGetUserState extends SocialStates {}

class SocialGetUserSuccessState extends SocialStates {}

class SocialGetUserErrorState extends SocialStates {
  final String error;

  SocialGetUserErrorState(this.error);
}

// bottom nav bar
class SocialChangeBottomNavState extends SocialStates {}

class SocialNewPostState extends SocialStates {}

// image picker states
// Profile
class SocialProfileImagePickedSuccessState extends SocialStates {}

class SocialProfileImagePickedErrorState extends SocialStates {
  String error;
  SocialProfileImagePickedErrorState({this.error});
}

//cover
class SocialGetCoverImageSuccessState extends SocialStates {}

class SocialGetCoverImageErrorState extends SocialStates {
  String error;
  SocialGetCoverImageErrorState({this.error});
}

// upload image
// Profile
class SocialUploadProfileSuccessState extends SocialStates {}

class SocialUploadProfileErrorState extends SocialStates {
  String error;
  SocialUploadProfileErrorState({this.error});
}

//cover
class SocialUploadCoverSuccessState extends SocialStates {}

class SocialUploadCoverErrorState extends SocialStates {
  String error;
  SocialUploadCoverErrorState({this.error});
}

// update User profile states
class SocialUpdateProfileLoadingState extends SocialStates {}

class SocialUpdateProfileErrorState extends SocialStates {}

//create post
class SocialCreatePostLoadingState extends SocialStates {}

class SocialCreatePostSuccessState extends SocialStates {}

class SocialCreatePostErrorState extends SocialStates {}

//get post image states
class SocialGetPostImageSuccessState extends SocialStates {}

class SocialGetPostImageErrorState extends SocialStates {
  String error;
  SocialGetPostImageErrorState({this.error});
}

class SocialRemovePostImageState extends SocialStates {}

// get Post states
class SocialLoadingGetPostState extends SocialStates {}

class SocialGetPostSuccessState extends SocialStates {}

class SocialGetPostErrorState extends SocialStates {
  final String error;

  SocialGetPostErrorState(this.error);
}

// like states
class SocialLikeSuccessState extends SocialStates {}

class SocialLikeErrorState extends SocialStates {
  final String error;

  SocialLikeErrorState(this.error);
}

//comment

class SocialToggleCommentState extends SocialStates {}

// Chat

class SocialSendMessageSuccessState extends SocialStates{}
class SocialSendMessageErrorState extends SocialStates{}
class SocialGetMessageSuccessState extends SocialStates{}
