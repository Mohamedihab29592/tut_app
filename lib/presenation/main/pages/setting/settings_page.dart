import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../app/app_prefs.dart';
import 'package:flutter_share/flutter_share.dart';

import 'dart:math' as math;
import 'package:flutter_phoenix/flutter_phoenix.dart';
import '../../../../app/di.dart';
import '../../../../data/data_source/local_data_source.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/langauge_manager.dart';
import '../../../resources/routs_manager.dart';
import '../../../resources/strings_manger.dart';
import '../../../resources/values_manger.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'contact_us.dart';
class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final AppPreferences _appPreferences = instance<AppPreferences>();
  final LocalDataSource _localDataSource = instance<LocalDataSource>();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        padding:  const EdgeInsets.all(AppPadding.p8),
        children: [
          ListTile(
            leading: SvgPicture.asset(ImageAssets.changeLangIc),
            title: Text(AppStrings.changeLanguage.tr(),
                style: Theme.of(context).textTheme.bodyLarge),
            trailing: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(isRtl() ? math.pi : 0),
              child: SvgPicture.asset(ImageAssets.rightArrowSettingsIc),
            ),
            onTap: () {
              _changeLanguage();
            },
          ),
          ListTile(
            leading: SvgPicture.asset(ImageAssets.contactUsIc),
            title: Text(AppStrings.contactUs.tr(),
                style: Theme.of(context).textTheme.bodyLarge),
            trailing: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(isRtl() ? math.pi : 0),
              child: SvgPicture.asset(ImageAssets.rightArrowSettingsIc),
            ),
            onTap: () {
              _contactUs();
            },
          ),
          ListTile(
            leading: SvgPicture.asset(ImageAssets.inviteFriendsIc),
            title: Text(AppStrings.inviteYourFriends.tr(),
                style: Theme.of(context).textTheme.bodyLarge),
            trailing: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(isRtl() ? math.pi : 0),
              child: SvgPicture.asset(ImageAssets.rightArrowSettingsIc),
            ),
            onTap: () {
              _inviteFriends();
            },
          ),
          ListTile(
            leading: SvgPicture.asset(ImageAssets.logoutIc),
            title: Text(AppStrings.logout.tr(),
                style: Theme.of(context).textTheme.bodyLarge),
            trailing: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(isRtl() ? math.pi : 0),
              child: SvgPicture.asset(ImageAssets.rightArrowSettingsIc),
            ),
            onTap: () {
              _logout();
            },
          )
        ],
      ),
    );
  }


  bool isRtl() {
    return context.locale == ARABIC_LOCAL;
  }


  _changeLanguage() {
    _appPreferences.changeAppLanguage();
    Phoenix.rebirth(context);
  }

  _contactUs() {
    Navigator.of(context).pushNamed(Routes.contactUs);
  }

  Future<void> _inviteFriends() async {
    await FlutterShare.share(
        title: AppStrings.appTitle.tr(),
        text: AppStrings.appTitle.tr(),
      linkUrl: AppStrings.appUrl,
        );
  }

  _logout() {
    // app prefs make that user logged out
    _appPreferences.logout();

    // clear cache of logged out user
    _localDataSource.clearCache();

    // navigate to login screen
    Navigator.pushReplacementNamed(context, Routes.loginRoute);
  }
}