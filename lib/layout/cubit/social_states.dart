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
class SocialCoverImageSuccessState extends SocialStates {}

class SocialCoverImageErrorState extends SocialStates {
  String error;
  SocialCoverImageErrorState({this.error});
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
