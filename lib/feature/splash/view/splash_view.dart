import 'package:flutter/material.dart';

import '../../../core/base/view/base_view.dart';
import '../../../core/components/lottie/lottie_widget.dart';
import '../viewmodel/splash_view_model.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<SplashViewModel>(
      viewModel: SplashViewModel(),
      onModelReady: (model) {
        model.setContext(context);
        model.init();
      },
      onPageBuilder: (BuildContext context, SplashViewModel viewModel) =>
          const Scaffold(
        body: Center(
          child: LottieCustomWidget(path: "splash"),
        ),
      ),
    );
  }
}
