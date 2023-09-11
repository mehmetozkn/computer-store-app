import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../core/base/view/base_view.dart';
import '../../../core/components/localetext/locale_text.dart';
import '../../../core/constants/enums/page_state.dart';
import '../../../core/constants/navigation/navigation_constants.dart';
import '../../../core/extension/context_extension.dart';
import '../../../core/init/language/locale_keys.g.dart';
import '../../../core/init/navigation/navigation_service.dart';
import '../model/product_model.dart';
import '../viewmodel/home_view_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeViewModel>(
      viewModel: HomeViewModel(),
      onModelReady: (model) {
        model.setContext(context);
        model.init();
      },
      onPageBuilder: (BuildContext context, HomeViewModel viewModel) {
        return Scaffold(
          appBar: buildAppBar(context),
          backgroundColor: Colors.blueGrey[400],
          bottomNavigationBar: buildBottomBar(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Stack(
            children: [
              buildFloatingButton(),
              buildNumberOfProduct(viewModel, context),
            ],
          ),
          body: Column(
            children: [
              buildTabBar(context, viewModel),
              buildPageView(viewModel),
            ],
          ),
        );
      },
    );
  }

  Observer buildPageView(HomeViewModel viewModel) {
    return Observer(
      builder: (_) {
        switch (viewModel.pageState) {
          case PageState.LOADING:
            return const Center(child: CircularProgressIndicator());
          case PageState.ERROR:
            return const Center(
              child: LocaleText(text: LocaleKeys.error_unexpectedError),
            );

          case PageState.SUCCESS:
            return buildListView(viewModel);
          default:
            return const Center(
                child: LocaleText(text: LocaleKeys.error_noProduct));
        }
      },
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.grey[300],
      title: const LocaleText(
        text: LocaleKeys.appName,
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }

  Padding buildTabBar(BuildContext context, HomeViewModel viewModel) {
    return Padding(
      padding: context.paddingNormal,
      child: Container(
        height: context.height * 0.04,
        decoration: BoxDecoration(
          color: Colors.blueGrey[400],
        ),
        child: TabBar(
          controller: _tabController,
          indicator: BoxDecoration(
            borderRadius: context.largeRadius,
            color: Colors.deepOrangeAccent,
          ),
          tabs: [
            Tab(
              child: Text(
                'All',
                textAlign: TextAlign.center,
                style: viewModel.style,
              ),
            ),
            Tab(
              child: Text(
                '8GB RAM',
                textAlign: TextAlign.center,
                style: viewModel.style,
              ),
            ),
            Tab(
              child: Text(
                '16GB RAM',
                textAlign: TextAlign.center,
                style: viewModel.style,
              ),
            ),
            Tab(
              child: Text(
                '32GB RAM',
                textAlign: TextAlign.center,
                style: viewModel.style,
              ),
            ),
          ],
          onTap: (index) {
            if (index == 0) {
              viewModel.getProductsByRam(null);
            } else if (index == 1) {
              viewModel.getProductsByRam(8);
            } else if (index == 2) {
              viewModel.getProductsByRam(16);
            } else if (index == 3) {
              viewModel.getProductsByRam(32);
            }
          },
        ),
      ),
    );
  }

  Positioned buildNumberOfProduct(
      HomeViewModel viewModel, BuildContext context) {
    return Positioned(
      top: 4,
      right: 4,
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.red,
        ),
        child: Observer(
          builder: (_) => Text(
            '${viewModel.basketItemCount}',
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  FloatingActionButton buildFloatingButton() {
    return FloatingActionButton(
      backgroundColor: Colors.white,
      onPressed: () {
        NavigationService.instance
            .navigateToPage(path: NavigationConstants.BASKET_VIEW);
      },
      child: const Icon(
        Icons.shopping_cart,
        color: Colors.blue,
      ),
    );
  }

  Expanded buildListView(HomeViewModel viewModel) {
    List<ProductModel> filterProducts =
        viewModel.getProductsByRam(viewModel.selectedRam);
    return Expanded(
      child: ListView.builder(
        itemCount: filterProducts.length,
        itemBuilder: (context, index) {
          return Padding(
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
                            filterProducts[index].imageUrl ?? ''),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Padding(
                      padding: context.paddingLow,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            filterProducts[index].name ?? '',
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: Colors.deepOrangeAccent,
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                          Text(filterProducts[index].processor ?? ''),
                          Text('${filterProducts[index].ram} GB RAM'),
                          Text('${filterProducts[index].storage} GB SSD'),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '\$${filterProducts[index].price}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: Colors.deepOrangeAccent,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.deepOrangeAccent),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: context.largeRadius,
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  viewModel.addProductToBasket(
                                      filterProducts[index].id ?? 0);
                                },
                                child: const LocaleText(
                                    text: LocaleKeys.order_add),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              )),
            ),
          );
        },
      ),
    );
  }

  BottomAppBar buildBottomBar() {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 8.0,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.home,
            ),
            onPressed: () {},
          ),
          const SizedBox(width: 48.0),
          IconButton(
            icon: const Icon(
              Icons.person,
            ),
            onPressed: () {
              NavigationService.instance
                  .navigateToPage(path: NavigationConstants.PROFILE_VIEW);
            },
          ),
        ],
      ),
    );
  }
}
