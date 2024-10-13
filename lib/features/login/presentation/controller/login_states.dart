
class LoginStates{}
class LoginInitialState extends LoginStates{ }
class LoginLoadingState extends LoginStates{ }
class LoginSuccessState extends LoginStates{ }
class LoginHidepassState extends LoginStates{ }
class LogincheckboxState extends LoginStates{ }
class LoginFailureState extends LoginStates{final String errorMessage;LoginFailureState({required this.errorMessage});}
class LoginGoogleFailureState extends LoginStates
{final String errorMessage;LoginGoogleFailureState({required this.errorMessage});}


