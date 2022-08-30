import 'dart:async';
import 'dart:ffi';
import '../../../../../domain/models/models.dart';
import '../../../../../domain/usecase/home_usecase.dart';
import '../../../../base/baseviewmodel.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../common/state_renderer/state_renderer.dart';
import '../../../../common/state_renderer/state_renderer_imp.dart';

class HomeViewModel extends BaseViewModel with HomeViewModelInput, HomeViewModelOutput {
  final _homeStreamController = BehaviorSubject<HomeViewObject>();

  final HomeUseCase _homeUseCase;

  HomeViewModel(this._homeUseCase);



  @override
  void dispose() {
    _homeStreamController.close();

    super.dispose();
  }

  @override
  void start() {
    _getHomeData();
  }
  _getHomeData() async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState));
    (await _homeUseCase.execute(Void)).fold(
            (failure) =>
        {
          // left -> failure
          inputState.add(ErrorState(
              StateRendererType.fullScreenErrorState, failure.message))
        }, (homeObject) {
      // right -> data (success)
      // content
      inputState.add(ContentState());
     inputHomeData.add(HomeViewObject(homeObject.data.stores, homeObject.data.services, homeObject.data.banners));
      // navigate to main screen
    });
  }


  @override
  Sink get inputHomeData => _homeStreamController.sink;

  // -- outputs
  @override
  Stream<HomeViewObject> get outputHomeData =>
      _homeStreamController.stream.map((data) => data);



}
abstract class HomeViewModelInput {
  Sink get inputHomeData;
}

abstract class HomeViewModelOutput {
  Stream<HomeViewObject> get outputHomeData;
}

class HomeViewObject {
  List<Store> stores;
  List<Service> services;
  List<BannerAd> banners;

  HomeViewObject(this.stores, this.services, this.banners);
}



