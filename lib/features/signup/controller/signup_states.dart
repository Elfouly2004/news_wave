
class SignupStates{}
class SignupInitialState extends SignupStates{ }
class SignupLoadingState extends SignupStates{ }
class RegisterSuccessState extends SignupStates{ }
class SignupFailureState extends SignupStates{

  final String errorMessage;SignupFailureState({required this.errorMessage});

}



