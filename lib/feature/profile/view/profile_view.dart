import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../core/base/view/base_view.dart';
import '../../../core/components/localetext/locale_text.dart';
import '../../../core/constants/navigation/navigation_constants.dart';
import '../../../core/extension/context_extension.dart';
import '../../../core/init/language/language_manager.dart';
import '../../../core/init/language/locale_keys.g.dart';
import '../../../core/init/navigation/navigation_service.dart';
import '../viewmodel/profile_view_model.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return BaseView<ProfileViewModel>(
      viewModel: ProfileViewModel(),
      onModelReady: (model) {
        model.setContext(context);
        model.init();
      },
      onPageBuilder: (BuildContext context, ProfileViewModel viewModel) =>
          Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: Center(
          child: Padding(
            padding: context.paddingVeryLarge,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                buildNameSurnameCircle(viewModel, context),
                buildNameSurnameField(context, viewModel),
                buildEmailField(context, viewModel),
                SizedBox(
                  height: context.height * 0.05,
                ),
                buildChangeLanguage(context),
                buildLogoutField(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Observer buildNameSurnameField(
      BuildContext context, ProfileViewModel viewModel) {
    return Observer(
      builder: (_) {
        return Padding(
          padding: context.paddingNormal,
          child: Text(
            "${viewModel.user?.name ?? ''} ${viewModel.user?.surname ?? ''}",
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        );
      },
    );
  }

  Observer buildEmailField(BuildContext context, ProfileViewModel viewModel) {
    return Observer(
      builder: (_) {
        return Text(
          viewModel.user?.email ?? '',
          style: Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(color: Colors.black),
        );
      },
    );
  }

  Observer buildNameSurnameCircle(
      ProfileViewModel viewModel, BuildContext context) {
    return Observer(builder: (_) {
      return CircleAvatar(
        backgroundColor: Colors.deepOrangeAccent,
        radius: 40,
        child: Text(
          "${viewModel.user?.name?.substring(0, 1) ?? ''}${viewModel.user?.surname?.substring(0, 1) ?? ''}",
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
        ),
      );
    });
  }

  InkWell buildChangeLanguage(BuildContext context) {
    return InkWell(
      onTap: () {
        context.locale.languageCode == 'tr'
            ? context.setLocale(LanguageManager.instance.supportedLocales[0])
            : context.setLocale(LanguageManager.instance.supportedLocales[1]);
      },
      child: Row(
        children: [
          Padding(
            padding: context.paddingLow,
            child: Row(
              children: [
                const Icon(
                  Icons.language,
                  color: Colors.grey,
                  size: 30,
                ),
                SizedBox(
                  width: context.width * 0.03,
                ),
                LocaleText(
                  text: LocaleKeys.language,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.deepOrangeAccent,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  ' - ${context.locale.countryCode.toString()}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.deepOrangeAccent,
                        fontWeight: FontWeight.bold,
                      ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  InkWell buildLogoutField(BuildContext context) {
    return InkWell(
      onTap: () async {
        await FirebaseAuth.instance.signOut();
        NavigationService.instance.navigateToPageClear(
          path: NavigationConstants.LOGIN_VIEW,
        );
      },
      child: Row(
        children: [
          Padding(
            padding: context.paddingLow,
            child: Row(
              children: [
                const Icon(
                  Icons.logout,
                  color: Colors.grey,
                  size: 30,
                ),
                SizedBox(
                  width: context.width * 0.03,
                ),
                LocaleText(
                  text: LocaleKeys.logout,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.deepOrangeAccent,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
