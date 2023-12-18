import 'package:first_task_1/core/controllers/profile_cubit/profile_states.dart';
import 'package:first_task_1/core/managers/values.dart';
import 'package:first_task_1/core/network/constant.dart';
import 'package:first_task_1/core/network/remote/dio_helper.dart';
import 'package:first_task_1/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit() : super(ProfileInitState());

  static ProfileCubit get(context) => BlocProvider.of(context);

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  UserModel? userModel;

  void getUserProfile() {
    emit(LoadingProfile());
    DioHelperStore.postData(
      url: ApiConstants.getProfileApi,
      data: {"token": token},
    ).then((value) {
      userModel = UserModel.fromJson(value.data);
      print('my token is ${userModel!.user!.token}');
      // Set the initial values for the controllers
      nameController.text = userModel!.user!.name ?? '';
      emailController.text = userModel!.user!.email ?? '';
      phoneController.text = userModel!.user!.phone ?? '';

      emit(ProfileDone(userModel!));
    }).catchError((error) {
      print('Error fetching user profile: $error');
      emit(ErrorProfile());
    });
  }

  void updateUserProfile({String? name, String? email, String? phone}) {
    emit(LoadingProfile());
    DioHelperStore.putData(
      url: ApiConstants.updateProfileApi,
      data: {
        "token": token,
        "name": name,
        "email": email,
        "phone": phone,
        "password": "12345678yu",
        "gender": "male",
      },
    ).then((value) {
      // Assuming `getUserProfile` method fetches updated data from the server
      if (name != null) userModel!.user!.name = name;
      if (email != null) userModel!.user!.email = email;
      if (phone != null) userModel!.user!.phone = phone;

      getUserProfile();
      emit(ProfileDone(userModel!));
      print(userModel!.user!.name);
    }).catchError((error) {
      print('Error updating user profile: $error');
      emit(ErrorProfile());
    });
  }

  void startEditingProfile() {
    emit(EditingProfile());
  }

  void cancelEditingProfile() {
    emit(ProfileDone(userModel!));
  }
}
