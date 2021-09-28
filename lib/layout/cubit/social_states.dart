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
