import 'dart:async';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter/material.dart';
import 'package:tut_app/presenation/resources/values_manger.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../resources/assets_manager.dart';
import '../../../resources/color_manger.dart';
import '../../../resources/strings_manger.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.contactUs.tr()),
      ),
      body:
        Padding(
          padding: const EdgeInsets.all(AppPadding.p20),
          child: Column(
            children:  [
              InkWell(
                onLongPress: (){},
                child: Row(
                  children:  [
                   Icon(Icons.phone,color: ColorManager.primary,size: AppSize.s30,),
                    const SizedBox(width:AppSize.s8,),
                    Text(AppStrings.mobileNo,style:Theme.of(context).textTheme.displayLarge,),



                  ],
                ),
              ),
              const SizedBox(height: AppSize.s20),
              InkWell(
                onLongPress: (){},
                child: Row(
                  children:  [
                   Icon(Icons.email,color: ColorManager.primary,size: AppSize.s30,),
                    const SizedBox(width:AppSize.s8,),
                    Text(AppStrings.email,style:Theme.of(context).textTheme.displayLarge,),



                  ],
                ),
              ),
              const SizedBox(height: AppSize.s20),

              InkWell(
                onTap: (){
                  _launchUrl();
                },
                child: Row(
                  children:   [
                const SizedBox(
                  height: AppSize.s40,
                    width: AppSize.s30,

                    child:Image(image: AssetImage(ImageAssets.linkedinLogo))),
                    const SizedBox(width:AppSize.s8,),
                    Text(AppStrings.name.tr(),style:Theme.of(context).textTheme.displayLarge,),

                  ],
                ),
              ),




              // WebView(),
            ],
          ),
        ),

    );
  }
  final Uri _url = Uri.parse(AppStrings.url);

  Future<void> _launchUrl() async {
    await launchUrl(_url,mode: LaunchMode.externalApplication) ;
  }
}
