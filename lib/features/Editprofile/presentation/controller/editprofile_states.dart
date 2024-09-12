
class EditprofileStates{}
class EditprofileInitialState extends EditprofileStates{ }
class EditprofileLoadingState extends EditprofileStates{ }
class EditprofileuccessState extends EditprofileStates{ }
class EditprofilFinishState extends EditprofileStates{ }
class EditprofileFailureState extends EditprofileStates{
  final String errorMessage;EditprofileFailureState({required this.errorMessage});
}


