import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:tut_app/app/di.dart';
import 'package:tut_app/presenation/resources/values_manger.dart';
import '../../../../../domain/models/models.dart';
import '../../../../common/state_renderer/state_renderer_imp.dart';
import '../../../../resources/routs_manager.dart';
import '../../../../resources/strings_manger.dart';
import '../viewmodel/search_viewmodel.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final SearchViewModel _viewModel = instance<SearchViewModel>();
  final TextEditingController _textController = TextEditingController();

  _bind() {
    _viewModel.start();
    _textController.addListener(() {
      _viewModel.setText(_textController.text);
    });
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.search.tr()),
      ),
      body: StreamBuilder(
          stream: _viewModel.outputState,
          builder: (context, snapshot) {
            return snapshot.data?.getScreenWidget(context, _getContentWidget(),
                    () {
                  _viewModel.searchData();
                }) ??
                _getContentWidget();
          }),
    );
  }

  Widget _getContentWidget() {
    return StreamBuilder<SearchViewObject>(
      stream: _viewModel.outputText,
      builder: (context, snapshot) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppPadding.p20),
              child: TextFormField(
                  keyboardType: TextInputType.text,
                  controller: _textController,
                  decoration: InputDecoration(
                      labelText: AppStrings.search.tr(),
                      suffixIcon: TextButton(
                        onPressed: () {
                          _viewModel.searchData();
                        },
                        child: Text(AppStrings.search.tr()),
                      ))),
            ),
            const SizedBox(
              height: AppSize.s28,
            ),
            _getStoresWidget(snapshot.data?.stores),
          ],
        );
      },
    );


  }

  Widget _getStoresWidget(List<SearchDataModel>? stores) {
    if (stores != null) {
      return Padding(
        padding: const EdgeInsets.only(
            left: AppPadding.p12, right: AppPadding.p12, top: AppPadding.p12),
        child: Flex(
          direction: Axis.vertical,
          children: [
            GridView.count(
              crossAxisCount: AppSize.s2,
              crossAxisSpacing: AppSize.s8,
              mainAxisSpacing: AppSize.s8,
              physics: const ScrollPhysics(),
              shrinkWrap: true,
              children: List.generate(stores.length, (index) {
                return InkWell(
                  onTap: () {
                    // navigate to store details screen
                    Navigator.of(context).pushNamed(Routes.storeDetailsRoute);
                  },
                  child: Card(
                    elevation: AppSize.s4,
                    child: Image.network(
                      stores[index].image,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }),
            )
          ],
        ),
      );
    } else {
      return Container();
    }
  }
}
