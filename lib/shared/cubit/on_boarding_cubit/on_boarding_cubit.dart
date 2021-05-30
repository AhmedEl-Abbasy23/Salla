import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/modules/login_screen/login_screen.dart';
import 'package:shop/shared/components/components.dart';
import 'package:shop/shared/network/local/cache_helper.dart';

import 'on_boarding_states.dart';

class BoardingCubit extends Cubit<OnBoardingStates> {
  BoardingCubit() : super(OnBoardingInitialState());

  static BoardingCubit get(context) => BlocProvider.of(context);
  int currentPageIndex = 0;

  bool isLast = false;

  void changePageIndex(int pageIndex) {
    currentPageIndex = pageIndex;
    emit(OnBoardingChangePageState());
  }

  void changeScreen(bool lastPage) {
    isLast = lastPage;
    emit(OnBoardingChangeScreenState());
  }

  void submit(context) {
    CacheHelper.saveData(key: 'onBoarding', value: true).then(
      (value) {
        if (value) {
          navigateAndFinish(context, LoginScreen());
        }
      },
    );
  }
}
