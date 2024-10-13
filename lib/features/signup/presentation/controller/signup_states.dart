
class SignupStates{}
class SignupInitialState extends SignupStates{ }
class SignupLoadingState extends SignupStates{ }
class SignupSuccessState extends SignupStates{ }
class SignupGoogleState extends SignupStates{ }
class SignupcheckboxState extends SignupStates{ }
class SignupFinishState extends SignupStates{ }
class SignupFailureState extends SignupStates{

  final String errorMessage;SignupFailureState({required this.errorMessage});

}class SignupGoogleFailureState extends SignupStates{

  final String errorMessage;SignupGoogleFailureState({required this.errorMessage});

}



