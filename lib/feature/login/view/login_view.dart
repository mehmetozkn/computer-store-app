import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../core/base/view/base_view.dart';
import '../../../core/components/localetext/locale_text.dart';
import '../../../core/constants/navigation/navigation_constants.dart';
import '../../../core/extension/context_extension.dart';
import '../../../core/extension/string_extension.dart';
import '../../../core/init/language/locale_keys.g.dart';
import '../../../core/init/navigation/navigation_service.dart';
import '../viewmodel/login_view_model.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<LoginViewModel>(
      viewModel: LoginViewModel(),
      onModelReady: (model) {
        model.setContext(context);
        model.init();
      },
      onPageBuilder: (BuildContext context, LoginViewModel viewModel) =>
          Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildTitleText(context),
              buildEmailField(context, viewModel),
              buildPasswordField(context, viewModel),
              buildLoginButtonField(context, viewModel),
              buildDivider(context),
              buildCreateAccountField(context),
            ],
          ),
        ),
      ),
    );
  }

  Row buildCreateAccountField(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const LocaleText(text: LocaleKeys.login_dontAccount),
        TextButton(
          onPressed: () {
            NavigationService.instance.navigateToPage(
              path: NavigationConstants.REGISTER_VIEW,
            );
          },
          child: LocaleText(
            text: LocaleKeys.register_createAccount,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Colors.deepOrangeAccent,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ],
    );
  }

  Padding buildTitleText(BuildContext context) {
    return Padding(
      padding: context.paddingNormal,
      child: LocaleText(
        text: LocaleKeys.appName,
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: Colors.deepOrange,
            fontWeight: FontWeight.bold,
            fontFamily: 'Pacifico'),
      ),
    );
  }

  Divider buildDivider(BuildContext context) {
    return Divider(
      height: context.height * 0.03,
      indent: context.height * 0.08,
      endIndent: context.height * 0.08,
      color: Colors.black,
      thickness: 1,
    );
  }

  Padding buildLoginButtonField(
      BuildContext context, LoginViewModel viewModel) {
    return Padding(
      padding: context.paddingNormal,
      child: SizedBox(
        height: context.buttondHeightValue,
        width: context.buttonWidthValue,
        child: ElevatedButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: context.mediumRadius,
                side: const BorderSide(
                  color: Colors.grey,
                ),
              ),
            ),
            backgroundColor: MaterialStateProperty.all<Color>(
              Colors.deepOrangeAccent,
            ),
          ),
          onPressed: () {
            viewModel.login(
              viewModel.emailController.text.trim(),
              viewModel.passwordController.text.trim(),
            );
          },
          child: const LocaleText(
            text: LocaleKeys.login_login,
          ),
        ),
      ),
    );
  }

  Padding buildEmailField(BuildContext context, LoginViewModel viewModel) {
    return Padding(
      padding: context.paddingNormal,
      child: SizedBox(
        height: context.textFieldHeightValue,
        width: context.textFieldWidthValue,
        child: TextFormField(
          controller: viewModel.emailController,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: context.mediumRadius,
            ),
            labelText: LocaleKeys.login_email.locale,
          ),
        ),
      ),
    );
  }

  SizedBox buildPasswordField(BuildContext context, LoginViewModel viewModel) {
    return SizedBox(
      height: context.textFieldHeightValue,
      width: context.textFieldWidthValue,
      child: Observer(builder: (_) {
        return TextFormField(
          obscureText: viewModel.obscureText,
          controller: viewModel.passwordController,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: context.mediumRadius,
              borderSide: const BorderSide(
                color: Colors.green,
              ),
            ),
            suffixIcon: IconButton(
              onPressed: () {
                viewModel.passwordVisibility();
              },
              icon: Observer(
                builder: (_) {
                  return Icon(
                    viewModel.obscureText ? Icons.lock : Icons.lock_open,
                  );
                },
              ),
            ),
            labelText: LocaleKeys.login_password.locale,
          ),
        );
      }),
    );
  }
}
