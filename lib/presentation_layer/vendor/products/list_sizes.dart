import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:provider/provider.dart';
import 'package:zohal/presentation_layer/vendor/products/server_products.dart';
import 'package:zohal/presentation_layer/vendor/products/util.dart';

class SizesList extends StatefulWidget {
  const SizesList({
    required String productId,
  }) : _productId = productId;

  final String _productId;

  @override
  _SizesListState createState() => _SizesListState();
}

class _SizesListState extends State<SizesList> {
  late Future<List<dynamic>> _getSizesFuture;

  Future<void> _refresh() async {
    setState(() {
      _getSizesFuture = MyServerProducts.getSizes(
        productId: widget._productId,
      );
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    //  final auth = Provider.of<Auth>(context, listen: false);

    _getSizesFuture = MyServerProducts.getSizes(
      productId: widget._productId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: _getSizesFuture,
      builder: (ctx, sizesState) {
        if (sizesState.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (sizesState.hasError) {
          return Center(
            child: Text(
              sizesState.error.toString(),
            ),
          );
        }

        if (sizesState.hasData) {
          final sizesList = sizesState.data!;

          if (sizesList.isEmpty) {
            return Center(
              child: Wrap(
                direction: Axis.vertical,
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  const Icon(
                    FontAwesomeIcons.listAlt,
                    size: 64,
                    color: Colors.deepOrange,
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Text(
                    'No Sizes Found!'.tr(),
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
              itemCount: sizesList.length,
              itemBuilder: (ctx, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  elevation: 4,
                  child: ListTile(
                    leading: const CircleAvatar(
                      radius: 28,
                      child: Icon(
                        FontAwesomeIcons.tshirt,
                      ),
                    ),
                    title: Text(
                      sizesList[index],
                    ),
                    trailing: Builder(builder: (context) {
                      //   if (ResponsiveWidget.isMediumScreen(context) ||
                      //       ResponsiveWidget.isLargeScreen(context))
                      //     return Row(
                      //       mainAxisSize: MainAxisSize.min,
                      //       children: [
                      //         IconButton(
                      //           onPressed: () async {
                      //             await ProductsUtil.showSizeDialog(
                      //               ctx,
                      //               {
                      //                 'isAdding': false,
                      //                 'index': index,
                      //                 'name': sizesList[index],
                      //                 '_id': widget._productId,
                      //               },
                      //               widget._auth,
                      //             ).then((hasEdited) {
                      //               if (hasEdited) _refresh(widget._auth);
                      //             });
                      //           },
                      //           icon: Icon(Icons.edit),
                      //           color: Get.theme.colorScheme.secondary,
                      //         ),
                      //         IconButton(
                      //           onPressed: () async {
                      //             await ProductsUtil.deleteSize(
                      //               ctx: context,
                      //               auth: widget._auth,
                      //               index: index,
                      //               id: widget._productId,
                      //             ).then((hasDeleted) {
                      //               if (hasDeleted)
                      //                 _refresh(
                      //                   widget._auth,
                      //                 );
                      //             });
                      //           },
                      //           icon: Icon(Icons.delete),
                      //           color: Get.theme.errorColor,
                      //         ),
                      //       ],
                      //     );
                      //

                      final pList = [
                        'Edit'.tr(),
                        'Delete'.tr(),
                      ];

                      return PopupMenuButton(
                        icon: const Icon(
                          Icons.more_vert_outlined,
                          color: Colors.grey,
                        ),
                        itemBuilder: (context) {
                          return pList.map((String value) {
                            return PopupMenuItem(
                              value: value,
                              child: Text(value),
                            );
                          }).toList();
                        },
                        onSelected: (selectedItem) async {
                          if (selectedItem == 'Edit' ||
                              selectedItem == 'تعديل') {
                            await ProductsUtil.showSizeDialog(
                              ctx,
                              {
                                'isAdding': false,
                                'index': index,
                                'name': sizesList[index],
                              },
                            ).then((hasEdited) {
                              if (hasEdited) _refresh();
                            });
                          } else {
                            await ProductsUtil.deleteSize(
                              ctx: context,
                              index: index,
                              id: widget._productId,
                            ).then((hasDeleted) {
                              if (hasDeleted) {
                                _refresh();
                              }
                            });
                          }
                        },
                      );
                    }),
                  ),
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
}
