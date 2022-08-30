

import 'dart:ffi';

import 'package:tut_app/presenation/base/baseviewmodel.dart';
import 'package:rxdart/rxdart.dart';
import '../../../domain/models/models.dart';
import '../../../domain/usecase/store_usecase.dart';
import '../../common/state_renderer/state_renderer.dart';
import '../../common/state_renderer/state_renderer_imp.dart';

class StoreViewModel extends BaseViewModel with StoreDetailsViewModelInput, StoreDetailsViewModelOutput{
  final _storeDetailsStreamController = BehaviorSubject<StoreDetails>();
  final StoreUseCase _storeUseCase;

  StoreViewModel(this._storeUseCase);


  @override
  void start() async {
    _loadData();
  }

  _loadData() async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState));
    (await _storeUseCase.execute(Void)).fold(
          (failure) {
        inputState.add(ErrorState(
            StateRendererType.fullScreenErrorState, failure.message));
      },
          (storeDetails) async {
        inputState.add(ContentState());
        inputStoreDetails.add(storeDetails);
      },
    );
  }

  @override
  void dispose() {
    _storeDetailsStreamController.close();
  }


  @override
  Sink get inputStoreDetails => _storeDetailsStreamController.sink;

  //output
  @override
  Stream<StoreDetails> get outputStoreDetails =>
      _storeDetailsStreamController.stream.map((stores) => stores);
}

abstract class StoreDetailsViewModelInput {
  Sink get inputStoreDetails;
}

abstract class StoreDetailsViewModelOutput {
  Stream<StoreDetails> get outputStoreDetails;
}