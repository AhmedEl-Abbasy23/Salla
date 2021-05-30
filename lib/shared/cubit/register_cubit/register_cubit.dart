import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/model/register_model/register_model.dart';
import 'package:shop/shared/cubit/register_cubit/register_states.dart';
import 'package:shop/shared/network/remote/dio_helper.dart';
import 'package:shop/shared/network/remote/end_point.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  late RegisterModel registerModel;

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(RegisterLoadingState());
    DioHelper.postData(
      url: REGISTER, //login from endPoint.
      data: {
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
      },
    ).then((value) {
      registerModel = RegisterModel.fromJson(value.data);
      emit(RegisterSuccessState(registerModel));
    }).catchError((error) {
      // ignore: avoid_print
      print('Error is: ${error.toString()}');
      emit(RegisterErrorState(error.toString()));
    });
  }
}
