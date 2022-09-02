import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:tut_app/presenation/resources/langauge_manager.dart';
import 'app/app.dart';
import 'app/di.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await initAppModule();
  runApp(EasyLocalization(
      supportedLocales: const [ARABIC_LOCAL, ENGLISH_LOCAL],
      path: ASSET_PATH_LOCALISATIONS,
      child: Phoenix(child: MyApp())));
}
