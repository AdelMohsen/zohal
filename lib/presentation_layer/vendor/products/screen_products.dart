import 'package:animations/animations.dart';
import 'package:easy_localization/src/public_ext.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:zohal/constance/strings.dart';
import 'package:zohal/presentation_layer/vendor/active_order/card_shipment.dart';
import 'package:zohal/presentation_layer/vendor/products/card_decorations.dart';
import 'package:zohal/presentation_layer/vendor/products/card_product.dart';
import 'package:zohal/presentation_layer/vendor/products/constants.dart';
import 'package:zohal/presentation_layer/vendor/products/list_sizes.dart';
import 'package:zohal/presentation_layer/vendor/products/my_utility.dart';
import 'package:zohal/presentation_layer/vendor/products/server_brands.dart';
import 'package:zohal/presentation_layer/vendor/products/server_products.dart';
import 'package:zohal/presentation_layer/vendor/products/server_sub_sections.dart';
import 'package:zohal/presentation_layer/vendor/products/server_vendors.dart';
import 'package:zohal/presentation_layer/vendor/products/util.dart';

class VendorProductsScreen extends StatefulWidget {
  @override
  _VendorProductsScreenState createState() => _VendorProductsScreenState();
}

class _VendorProductsScreenState extends State<VendorProductsScreen> {
  late Future<List<dynamic>> _getDecorationsFuture;

  late Future<List<dynamic>> _getProductsFuture;

  late Future<List<dynamic>> _getSubsectionsFuture;

  late Future<List<dynamic>> _getBrandsFuture;

  var _showProducts = true;
  var _showSizes = false;
  var _selectedProductId = '';

  Future<void> _refresh() async {
    setState(() {
      _getProductsFuture = MyServerVendors.getProductsList();

      _getSubsectionsFuture = MyServerSubSections.getListNoCategory();

      _getBrandsFuture = MyServerBrands.getList();
    });
  }

  Future<void> _refreshDecors() async {
    setState(() {
      _getDecorationsFuture = MyServerProducts.getDecorations(
        _selectedProductId,
      );
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _getProductsFuture = MyServerVendors.getProductsList();

    _getSubsectionsFuture = MyServerSubSections.getListNoCategory();

    _getBrandsFuture = MyServerBrands.getList();
  }

  Widget _productsBody() {
    return FutureBuilder<List<dynamic>>(
      future: _getProductsFuture,
      builder: (ctx, productsState) {
        if (productsState.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (productsState.hasError) {
          return Center(
            child: Text(productsState.error.toString()),
          );
        }

        if (productsState.hasData) {
          final productsList = productsState.data!;

          if (productsList.isEmpty) {
            return Center(
              child: Wrap(
                direction: Axis.vertical,
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  const Icon(
                    FontAwesomeIcons.listAlt,
                    size: 64,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Text(
                    'No Products Found!'.tr(),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () => _refresh(),
            child: ListView.builder(
              padding: const EdgeInsets.only(
                top: 10,
                bottom: 10,
                right: 5,
                left: 5,
              ),
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              itemCount: productsList.length,
              itemBuilder: (ctx, index) {
                return ProductCard(
                  name: productsList[index]['name'],
                  arabicName: productsList[index]['arabicName'],
                  model: productsList[index]['model'],
                  price: productsList[index]['price'],
                  discountPrice: productsList[index]['discountPrice'],
                  status: productsList[index]['status'],
                  hasSizes: productsList[index]['hasSizes'],
                  vendor: productsList[index]['vendor'],
                  editCallback: () async {
                    _getBrandsFuture.then((brandsList) {
                      if (brandsList.isNotEmpty) {
                        _getSubsectionsFuture.then((subsectionsList) {
                          if (subsectionsList.isNotEmpty) {
                            ProductsUtil.showVendorProductDialog(
                              ctx,
                              {
                                'isAdding': false,
                                'id': productsList[index]['_id'],
                                'name': productsList[index]['name'],
                                'arabicName': productsList[index]['arabicName'],
                                'model': productsList[index]['model'],
                                'price': productsList[index]['price'],
                                'description': productsList[index]
                                    ['description'],
                                'inStock': productsList[index]['inStock'],
                                'brandId': productsList[index]['brand']['_id'],
                                'vendorId': productsList[index]['vendor']
                                    ['_id'],
                                'categoryId': productsList[index]['subSection']
                                    ['category'],
                                'sectionId': productsList[index]['subSection']
                                    ['section'],
                                'subSectionId': productsList[index]
                                    ['subSection']['_id'],
                                'subsectionsList': subsectionsList,
                                'brandsList': brandsList,
                              },
                            ).then((hasEdited) {
                              if (hasEdited) _refresh();
                            });
                          } else {
                            showSnackBar(
                              context: context,
                              msg: 'No Sub-Sections Found!'.tr(),
                            );
                          }
                        }).onError((error, stackTrace) {
                          print(stackTrace);
                          showSnackBar(
                            context: context,
                            msg: error.toString(),
                          );
                        });
                      } else {
                        showSnackBar(
                          context: context,
                          msg: 'No Brands Found!'.tr(),
                        );
                      }
                    }).onError((error, stackTrace) {
                      print(stackTrace);
                      showSnackBar(
                        context: context,
                        msg: error.toString(),
                      );
                    });
                  },
                  decorationsCallback: () {
                    setState(() {
                      _selectedProductId = productsList[index]['_id'];
                      _getDecorationsFuture = MyServerProducts.getDecorations(
                        productsList[index]['_id'],
                      );
                      _showProducts = false;
                      _showSizes = false;
                    });
                  },
                  deleteCallback: null,
                  sizesCallback: () {
                    setState(() {
                      _selectedProductId = productsList[index]['_id'];
                      _showProducts = false;
                      _showSizes = true;
                    });
                  },
                  discountCallback: () async {
                    await ProductsUtil.discountProduct(
                      context,
                      productsList[index]['_id'],
                      productsList[index]['price'],
                      productsList[index]['discountPrice'],
                    ).then((hasChanged) {
                      if (hasChanged) _refresh();
                    });
                  },
                  historyCallback: () {},
                  statusCallback: null,
                );
              },
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget _decorationsBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(
            12,
          ),
          child: FloatingActionButton(
            child: const Icon(
              FontAwesomeIcons.arrowUp,
            ),
            onPressed: () {
              setState(() {
                _showProducts = true;
                _refresh();
              });
            },
          ),
        ),
        Expanded(
          child: FutureBuilder<List<dynamic>>(
            future: _getDecorationsFuture,
            builder: (ctx, decorsState) {
              if (decorsState.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (decorsState.hasError) {
                return Center(
                  child: Text(decorsState.error.toString()),
                );
              }

              if (decorsState.hasData) {
                final decorsList = decorsState.data!;
                return RefreshIndicator(
                  onRefresh: () => _refreshDecors(),
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8.0),
                    physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    itemCount: decorsList.length,
                    itemBuilder: (ctx, index) {
                      final image1Url = decorsList[index]['image1Url'] != null
                          ? MyServerConst.BASE_URL +
                              decorsList[index]['image1Url'] +
                              '?v=${MyUtil.toRefreshImages()}'
                          : '';

                      final image2Url = decorsList[index]['image2Url'] != null
                          ? MyServerConst.BASE_URL +
                              decorsList[index]['image2Url'] +
                              '?v=${MyUtil.toRefreshImages()}'
                          : '';

                      final image3Url = decorsList[index]['image3Url'] != null
                          ? MyServerConst.BASE_URL +
                              decorsList[index]['image3Url'] +
                              '?v=${MyUtil.toRefreshImages()}'
                          : '';

                      final image4Url = decorsList[index]['image4Url'] != null
                          ? MyServerConst.BASE_URL +
                              decorsList[index]['image4Url'] +
                              '?v=${MyUtil.toRefreshImages()}'
                          : '';

                      return DecorationsCard(
                        image1Url: image1Url,
                        image2Url: image2Url,
                        image3Url: image3Url,
                        image4Url: image4Url,
                        image2NullCheck: decorsList[index]['image2Url'] != null,
                        image3NullCheck: decorsList[index]['image3Url'] != null,
                        image4NullCheck: decorsList[index]['image4Url'] != null,
                        color: decorsList[index]['color'],
                        imageCount: (decorsList[index].length - 2).toString(),
                        editCallback: () async {
                          await ProductsUtil.showDecorDialog(
                            context,
                            {
                              'isAdding': false,
                              'id': _selectedProductId,
                              'decorId': decorsList[index]['_id'],
                              'color': decorsList[index]['color'],
                              'image1Url': image1Url,
                              'image2Url': image2Url == '' ? '' : image2Url,
                              'image3Url': image3Url == '' ? '' : image3Url,
                              'image4Url': image4Url == '' ? '' : image4Url,
                            },
                          ).then((hasEdited) {
                            if (hasEdited) {
                              _refreshDecors();
                            }
                          });
                        },
                        deleteCallback: () async {
                          await ProductsUtil.deleteDecor(
                            context,
                            _selectedProductId,
                            decorsList[index]['_id'],
                          ).then((hasDeleted) {
                            if (hasDeleted) {
                              imageCache?.clear();
                              _refreshDecors();
                            }
                          });
                        },
                      );
                    },
                  ),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _sizesBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(
            12,
          ),
          child: FloatingActionButton(
            child: const Icon(
              FontAwesomeIcons.arrowUp,
            ),
            onPressed: () {
              setState(() {
                _showProducts = true;
                _refresh();
              });
            },
          ),
        ),
        Expanded(
          child: SizesList(
            productId: _selectedProductId,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        label: Text(
          'Add'.tr(),
        ),
        icon: const Icon(
          Icons.add,
        ),
        onPressed: _showProducts
            ? () {
                _getBrandsFuture.then((brandsList) {
                  if (brandsList.isNotEmpty) {
                    _getSubsectionsFuture.then((subsectionsList) {
                      if (subsectionsList.isNotEmpty) {
                        ProductsUtil.showVendorProductDialog(
                          context,
                          {
                            'isAdding': true,
                            'name': '',
                            'arabicName': '',
                            'model': '',
                            'price': '',
                            'description': '',
                            'inStock': '1',
                            'hasSizes': '1',
                            'brandId': '',
                            'categoryId': subsectionsList[0]['category']['_id'],
                            'sectionId': subsectionsList[0]['section']['_id'],
                            'subSectionId': subsectionsList[0]['_id'],
                            'brandsList': brandsList,
                            'subsectionsList': subsectionsList,
                            'vendorId': userId,
                          },
                        ).then((hasAdded) {
                          if (hasAdded) _refresh();
                        });
                      } else {
                        showSnackBar(
                          context: context,
                          msg: 'No Sub-Sections Found!'.tr(),
                        );
                      }
                    }).onError((error, stackTrace) {
                      print(stackTrace);
                      showSnackBar(
                        context: context,
                        msg: error.toString(),
                      );
                    });
                  } else {
                    showSnackBar(
                      context: context,
                      msg: 'No Brands Found!'.tr(),
                    );
                  }
                }).onError((error, stackTrace) {
                  print(stackTrace);
                  showSnackBar(
                    context: context,
                    msg: error.toString(),
                  );
                });
              }
            : _showSizes
                ? () {
                    ProductsUtil.showSizeDialog(
                      context,
                      {
                        'isAdding': true,
                        'name': '',
                        '_id': _selectedProductId,
                      },
                    ).then((hasAdded) {
                      if (hasAdded) {
                        showSnackBar(
                          context: context,
                          msg: 'Pull to Refresh'.tr(),
                        );
                      }
                    });
                  }
                : () {
                    ProductsUtil.showDecorDialog(
                      context,
                      {
                        'isAdding': true,
                        'id': _selectedProductId,
                        'color': '#',
                        'image1Url': '',
                        'image2Url': '',
                        'image3Url': '',
                        'image4Url': '',
                      },
                    ).then((hasAdded) {
                      if (hasAdded) {
                        _refreshDecors();
                      }
                    });
                  },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: SafeArea(
        child: PageTransitionSwitcher(
          transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
            return FadeThroughTransition(
              animation: primaryAnimation,
              secondaryAnimation: secondaryAnimation,
              child: child,
            );
          },
          child: _showProducts
              ? _productsBody()
              : _showSizes
                  ? _sizesBody()
                  : _decorationsBody(),
        ),
      ),
    );
  }
}
