import 'package:first_task_1/core/controllers/login_cubit/login_states.dart';
import 'package:first_task_1/core/managers/values.dart';
import 'package:first_task_1/core/network/constant.dart';
import 'package:first_task_1/core/network/local/cache_helper.dart';
import 'package:first_task_1/core/network/remote/dio_helper.dart';
import 'package:first_task_1/models/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitState());

  static LoginCubit get(context) => BlocProvider.of(context);

  void userLogin({required String email, required String password}) {
    emit(LoginLoadingState());

    DioHelperStore.postData(
      url: ApiConstants.loginApi,
      data: {
        "email": email,
        "password": password,
      },
    ).then((value) {
      UserModel loginModel = UserModel.fromJson(value.data);

      if (loginModel.status == "success") {
        CacheHelper.saveData(
          key: 'userId',
          value: loginModel.user!.nationalId,
        ).then((value) {
          natoinalId = loginModel.user!.nationalId;
        });

        CacheHelper.saveData(
          key: 'token',
          value: loginModel.user!.token!,
        ).then((value) {
          token = loginModel.user!.token!;
          emit(LoginSuccessState(loginModel));
        });
      } else {
        emit(LoginErrorState(loginModel.message!));
      }
    }).catchError((error) {
      emit(LoginErrorState("An error occurred. Please try again."));
      print(error.toString());
    });
  }
}
