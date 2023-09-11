import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../core/base/view/base_view.dart';
import '../../../core/components/localetext/locale_text.dart';
import '../../../core/constants/navigation/navigation_constants.dart';
import '../../../core/extension/context_extension.dart';
import '../../../core/extension/string_extension.dart';
import '../../../core/init/language/locale_keys.g.dart';
import '../../../core/init/navigation/navigation_service.dart';
import '../viewmodel/register_view_model.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<RegisterViewModel>(
      viewModel: RegisterViewModel(),
      onModelReady: (model) {
        model.setContext(context);
        model.init();
      },
      onPageBuilder: (BuildContext context, RegisterViewModel viewModel) =>
          Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildTitleText(context),
              buildNameField(context, viewModel),
              buildSurnameField(context, viewModel),
              buildEmailField(context, viewModel),
              buildPasswordField(context, viewModel),
              buildDivider(context),
              buildRegisterButton(context, viewModel),
              buildLoginPageText(context),
            ],
          ),
        ),
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

  Padding buildNameField(BuildContext context, RegisterViewModel viewModel) {
    return Padding(
      padding: context.paddingNormal,
      child: SizedBox(
        height: context.textFieldHeightValue,
        width: context.textFieldWidthValue,
        child: TextFormField(
          controller: viewModel.nameController,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: context.mediumRadius,
            ),
            labelText: LocaleKeys.user_name.locale,
          ),
        ),
      ),
    );
  }

  SizedBox buildSurnameField(
      BuildContext context, RegisterViewModel viewModel) {
    return SizedBox(
      height: context.textFieldHeightValue,
      width: context.textFieldWidthValue,
      child: TextFormField(
        controller: viewModel.surnameController,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: context.mediumRadius,
          ),
          labelText: LocaleKeys.user_surname.locale,
        ),
      ),
    );
  }

  Padding buildEmailField(BuildContext context, RegisterViewModel viewModel) {
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
            labelText: LocaleKeys.register_email.locale,
          ),
        ),
      ),
    );
  }

  SizedBox buildPasswordField(
      BuildContext context, RegisterViewModel viewModel) {
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
            labelText: LocaleKeys.register_password.locale,
          ),
        );
      }),
    );
  }

  Padding buildRegisterButton(
      BuildContext context, RegisterViewModel viewModel) {
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
            child: const LocaleText(text: LocaleKeys.register_signup),
            onPressed: () {
              viewModel.register(
                name: viewModel.nameController.text.trim(),
                surname: viewModel.surnameController.text.trim(),
                email: viewModel.emailController.text.trim(),
                password: viewModel.passwordController.text.trim(),
              );
            }),
      ),
    );
  }

  Row buildLoginPageText(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const LocaleText(text: LocaleKeys.register_haveAccount),
        TextButton(
          onPressed: () {
            NavigationService.instance.navigateToPageClear(
              path: NavigationConstants.LOGIN_VIEW,
            );
          },
          child: LocaleText(
            text: LocaleKeys.register_login,
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: Colors.deepOrangeAccent),
          ),
        ),
      ],
    );
  }
}
