import 'package:flutter/material.dart';

import '../../init/cache/locale_manager.dart';
import '../../init/navigation/navigation_service.dart';

mixin BaseViewModel {
  late BuildContext viewModelContext;
  LocaleManager localeManager = LocaleManager.instance;
  NavigationService navigation = NavigationService.instance;

  void setContext(BuildContext context);
  void init();
}
