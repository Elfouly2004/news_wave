
class LoginStates{}
class LoginInitialState extends LoginStates{ }
class LoginLoadingState extends LoginStates{ }
class LoginSuccessState extends LoginStates{ }
class LoginFailureState extends LoginStates{

  final String errorMessage;LoginFailureState({required this.errorMessage});

}


