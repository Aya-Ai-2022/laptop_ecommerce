// ignore_for_file: avoid_print

import 'package:first_task_1/core/controllers/onboarding_cubit/onboarding_states.dart';
import 'package:first_task_1/core/managers/nav.dart';
import 'package:first_task_1/core/network/local/cache_helper.dart';
import 'package:first_task_1/screens/modules/login.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class OnBoardingCubit extends Cubit<OnboardingStates>{
  OnBoardingCubit() : super(OnboardingInitState());
  static OnBoardingCubit get(context) => BlocProvider.of(context);
  bool isPageLast = false;
  int screenIndex = 0;
  void pageLast(index){
    isPageLast = true;
    screenIndex = index;
    print(screenIndex);
    emit(PageLast());
  }
  void pageNotLast(index){
    isPageLast = false;
    screenIndex = index;
    print(screenIndex);
    emit(NotPageLast());
  }
  void submit(context){
    CacheHelper.saveData(key:'Boarding', value:true).then((value)=>
    navigateToNextScreen(context, LoginScreen()));
  }
}