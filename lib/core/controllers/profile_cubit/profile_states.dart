import 'package:first_task_1/models/user_model.dart';

abstract class ProfileStates {}

class ProfileInitState extends ProfileStates {}

class LoadingProfile extends ProfileStates {}

class ProfileDone extends ProfileStates {
  final UserModel userModel;

  ProfileDone(this.userModel);
}

class ErrorProfile extends ProfileStates {}

class EditingProfile extends ProfileStates {}
