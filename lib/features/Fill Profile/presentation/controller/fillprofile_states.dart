
class FillprofileStates{}
class FillprofileInitialState extends FillprofileStates{ }
class FillprofileLoadingState extends FillprofileStates{ }
class FillprofileuccessState extends FillprofileStates{ }
class FillprofilFinishState extends FillprofileStates{ }
class FillprofileFailureState extends FillprofileStates{
  final String errorMessage;FillprofileFailureState({required this.errorMessage});
}


