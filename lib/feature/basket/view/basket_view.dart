import 'package:computer_store_app/core/components/icon-button/custom_icon_button.dart';
import 'package:computer_store_app/core/components/localetext/locale_text.dart';
import 'package:computer_store_app/core/constants/enums/page_state.dart';
import 'package:computer_store_app/core/constants/navigation/navigation_constants.dart';
import 'package:computer_store_app/core/extension/string_extension.dart';
import 'package:computer_store_app/core/init/language/locale_keys.g.dart';
import 'package:computer_store_app/core/init/navigation/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../core/base/view/base_view.dart';
import '../../../core/extension/context_extension.dart';
import '../model/basket_product_model.dart';
import '../viewmodel/basket_view_model.dart';

class BasketView extends StatelessWidget {
  const BasketView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<BasketViewModel>(
      viewModel: BasketViewModel(),
      onModelReady: (model) {
        model.setContext(context);
        model.init();
      },
      onPageBuilder: (BuildContext context, BasketViewModel viewModel) =>
          Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: buildAppBar(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildPageView(viewModel),
            buildTotalPrice(viewModel, context),
            buildButton(context, viewModel),
          ],
        ),
      ),
    );
  }

  Padding buildButton(BuildContext context, BasketViewModel viewModel) {
    return Padding(
      padding: context.paddingLarge,
      child: Center(
        child: SizedBox(
          height: context.height * 0.04,
          width: context.width * 0.6,
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(Colors.deepOrangeAccent),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: context.mediumRadius,
                ),
              ),
            ),
            onPressed: () {
              viewModel.clearBasket();
            },
            child: Text(LocaleKeys.order_completeOrder.locale),
          ),
        ),
      ),
    );
  }

  Observer buildPageView(BasketViewModel viewModel) {
    return Observer(
      builder: (_) {
        switch (viewModel.pageState) {
          case PageState.LOADING:
            return const Center(child: CircularProgressIndicator());
          case PageState.ERROR:
            return Center(
              child: Text(LocaleKeys.error_unexpectedError.locale),
            );
          case PageState.SUCCESS:
            return buildListView(viewModel);
          default:
            return Center(
              child: Text(LocaleKeys.order_myBasket.locale),
            );
        }
      },
    );
  }

  Padding buildTotalPrice(BasketViewModel viewModel, BuildContext context) {
    return Padding(
      padding: context.paddingLarge,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            LocaleKeys.order_totalPrice.locale,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
          ),
          Observer(builder: (_) {
            return Text(
              '\$${viewModel.totalAmount.toString()}',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.deepOrangeAccent,
                    fontWeight: FontWeight.bold,
                  ),
            );
          })
        ],
      ),
    );
  }

  Expanded buildListView(BasketViewModel viewModel) {
    return Expanded(
      child: ListView.builder(
        itemCount: viewModel.products.length,
        itemBuilder: (context, index) {
          return viewModel.products[index].quantity! > 0
              ? Padding(
                  padding: context.paddingLow,
                  child: Container(
                    height: context.height * 0.2,
                    decoration: BoxDecoration(
                      borderRadius: context.mediumRadius,
                      border: Border.all(
                        color: Colors.white,
                      ),
                    ),
                    child: Center(
                        child: Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Padding(
                            padding: context.paddingLow,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: context.mediumRadius,
                              ),
                              child: Image.network(
                                  height: context.height * 0.2,
                                  viewModel.products[index].product?.imageUrl ??
                                      ''),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: Padding(
                            padding: context.paddingLow,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                buildProductNameText(
                                    viewModel.products, index, context),
                                buildProductProcessorText(viewModel, index),
                                Text(
                                    '${viewModel.products[index].product?.ram?.toString() ?? ''} GB RAM'),
                                Text(
                                    '${viewModel.products[index].product?.storage?.toString() ?? ''} GB SSD'),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '\$${(viewModel.products[index].product?.price ?? 0) * (viewModel.products[index].quantity ?? 1)}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            color: Colors.deepOrangeAccent,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    Observer(
                                      builder: (_) {
                                        return Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            buildRemoveProductIconButton(
                                                viewModel, index),
                                            buildProductCounterText(
                                                viewModel, index, context),
                                            buildAddProductIconButton(
                                                viewModel, index),
                                          ],
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )),
                  ),
                )
              : const SizedBox();
        },
      ),
    );
  }

  Text buildProductProcessorText(BasketViewModel viewModel, int index) {
    return Text(viewModel.products[index].product?.processor ?? '');
  }

  CustomIconButton buildAddProductIconButton(
      BasketViewModel viewModel, int index) {
    return CustomIconButton(
      onPressed: () => viewModel.addProductToBasket(
        viewModel.products[index].product?.id,
        1,
        viewModel.products[index].quantity,
      ),
      icon: const Icon(
        Icons.add,
        color: Colors.deepOrangeAccent,
      ),
    );
  }

  Text buildProductCounterText(
      BasketViewModel viewModel, int index, BuildContext context) {
    return Text(
      '${viewModel.products[index].quantity}',
      style: Theme.of(context)
          .textTheme
          .bodyLarge
          ?.copyWith(fontWeight: FontWeight.bold),
    );
  }

  CustomIconButton buildRemoveProductIconButton(
      BasketViewModel viewModel, int index) {
    return CustomIconButton(
      onPressed: () => viewModel.addProductToBasket(
        viewModel.products[index].product?.id,
        -1,
        viewModel.products[index].quantity,
      ),
      icon: const Icon(
        Icons.remove,
        color: Colors.deepOrangeAccent,
      ),
    );
  }

  Text buildProductNameText(
      List<BasketProductModel> products, int index, BuildContext context) {
    return Text(
      products[index].product?.name ?? '',
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.grey[300],
      iconTheme: const IconThemeData(color: Colors.black),
      title: const LocaleText(
        text: LocaleKeys.order_myBasket,
        style: TextStyle(color: Colors.black),
      ),
      leading: IconButton(
        onPressed: () {
          NavigationService.instance.navigateToPageClear(
            path: NavigationConstants.HOME_VIEW,
          );
        },
        icon: const Icon(
          Icons.arrow_back_ios,
        ),
      ),
    );
  }
}
