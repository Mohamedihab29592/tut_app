import 'dart:async';

import 'package:tut_app/domain/models/models.dart';
import 'package:tut_app/domain/usecase/search_usecase.dart';
import 'package:tut_app/presenation/base/baseviewmodel.dart';

import '../../../../../app/constants.dart';
import '../../../../../app/di.dart';
import '../../../../../data/network/dio_factory.dart';
import '../../../../common/state_renderer/state_renderer.dart';
import '../../../../common/state_renderer/state_renderer_imp.dart';

class SearchViewModel extends BaseViewModel
    with SearchViewModelInput, SearchViewModelOutput {
  StreamController textStreamController = StreamController<String>.broadcast();
  final SearchUseCase _searchUseCase;

  SearchViewModel(this._searchUseCase);

  var text = "";

  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  searchData() async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.popupLoadingState));
    (await _searchUseCase.execute(text)).fold((failure) {
      inputState.add(
          ErrorState(StateRendererType.popupErrorState  , failure.message));
    }, (searchDataModel) {
      inputState.add(ContentState());
      inputText.add(SearchDataModel);

    });
  }

  @override
  setText(String text) {
    inputText.add(text);
    this.text = text;
  }

  @override
  Sink get inputText => textStreamController.sink;

  @override
  void dispose() {
    textStreamController.close();
  }

  @override
  Stream<SearchViewObject> get outputText =>
      textStreamController.stream.map((data) => data);


}

abstract class SearchViewModelInput {
  searchData();
  setText(String text);

  Sink get inputText;
}

abstract class SearchViewModelOutput {
  Stream<SearchViewObject> get outputText;
}

class SearchViewObject {
  List<SearchDataModel> stores;
  SearchViewObject(this.stores,);
}
