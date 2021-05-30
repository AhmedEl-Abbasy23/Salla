import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/model/search_model/search_model.dart';
import 'package:shop/shared/components/constants.dart';
import 'package:shop/shared/cubit/search_cubit/search_states.dart';
import 'package:shop/shared/network/remote/dio_helper.dart';
import 'package:shop/shared/network/remote/end_point.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  late SearchModel searchModel;

  void search(String text) {
    emit(SearchLoadingState());

    DioHelper.postData(
      url: SEARCH,
      data: {'text': text},
      token: token,
    ).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      emit(SearchSuccessState());
      // print(value.data.runtimeType);
    }).catchError((error) {
      print('error is: ${error.toString()}');
      emit(SearchErrorState());
    });
  }
}
