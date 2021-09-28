import 'package:social_app/models/login_model.dart';

abstract class SocialLoginStates {}

class SocialLoginInitialState extends SocialLoginStates {}

class SocialLoginLoadingState extends SocialLoginStates {}

class SocialLoginSuccessState extends SocialLoginStates {
  final String uId;
  SocialLoginSuccessState(this.uId);
}

class SocialLoginErrorState extends SocialLoginStates {
  final String error;
  SocialLoginErrorState(this.error);
}

class SocialPasswordVisibilityState extends SocialLoginStates {}
