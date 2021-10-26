import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:zohal/constance/end_point.dart';
import 'package:zohal/constance/reuse_widget.dart';
import 'package:zohal/constance/strings.dart';
import 'package:zohal/presentation_layer/vendor/active_order/server_order.dart';

class ShipmentCard extends StatelessWidget {
  ShipmentCard({
    required String id,
    required bool isExpanded,
    required String createdAt,
    required Map<String, dynamic> customer,
    required Map<String, dynamic> coupon,
    required List<dynamic> shipments,
    required Function refreshCallback,
  })  : _id = id,
        _isExpanded = isExpanded,
        _createdAt = createdAt,
        _customer = customer,
        _shipments = shipments,
        _refreshCallback = refreshCallback;

  final String _id;
  final bool _isExpanded;
  final String _createdAt;
  final Map<String, dynamic> _customer;
  final List<dynamic> _shipments;
  final Function _refreshCallback;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      elevation: 4,
      shape: Border.all(
        color: Colors.black26,
        width: 1,
      ),
      child: ExpansionTile(
        title: Text('Order Date:'.tr().toString() +
            formatDate(
              _createdAt,
              true,
            )),
        subtitle: Text(
          'Order ID:'.tr() + _id,
        ),
        initiallyExpanded: _isExpanded,
        controlAffinity: ListTileControlAffinity.leading,
        childrenPadding: const EdgeInsets.all(
          8,
        ),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Customer Id: '.tr(),
                style: Theme.of(context).textTheme.subtitle2,
              ),
              Text(_customer['_id']),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          ..._shipments.mapIndexed(
            (shipment, i) {
              final List<dynamic> products = shipment['products'];
              final vendorId = shipment['vendor'];

              if (vendorId['_id'] == userId) {
                return Card(
                  elevation: 6,
                  margin: const EdgeInsets.all(
                    8,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(
                      4.0,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Shipment #${i + 1}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            shipment['status'] == '0'
                                ? Row(
                                    children: [
                                      IconButton(
                                        tooltip:
                                            'Check: Ready for Shipping'.tr(),
                                        onPressed: () async {
                                          await changeShipmentStatusForVendors(
                                            ctx: context,
                                            id: _id,
                                            shipmentIndex: i.toString(),
                                            newStatus: '1',
                                          ).then((hasUpdated) {
                                            if (hasUpdated) _refreshCallback();
                                          });
                                        },
                                        icon: const Icon(
                                          Icons.check_circle_outline,
                                          color: Colors.green,
                                        ),
                                      ),
                                      IconButton(
                                        tooltip: 'Check: Not Ready for Shipping'
                                            .tr(),
                                        onPressed: () async {
                                          await changeShipmentStatusForVendors(
                                            ctx: context,
                                            id: _id,
                                            shipmentIndex: i.toString(),
                                            newStatus: '-1',
                                          ).then((hasUpdated) {
                                            if (hasUpdated) {
                                              _refreshCallback();
                                            }
                                          });
                                        },
                                        icon: const Icon(
                                          Icons.cancel_outlined,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  )
                                : IconButton(
                                    tooltip: int.parse(shipment['status']) >= 1
                                        ? 'Marked: Ready For Shipping'.tr()
                                        : 'Marked: Not Ready For Shipping'.tr(),
                                    onPressed: null,
                                    icon: int.parse(shipment['status']) >= 1
                                        ? const Icon(
                                            Icons.done_outline,
                                            color: Colors.green,
                                          )
                                        : const Icon(
                                            Icons.check_circle,
                                            color: Colors.red,
                                          ),
                                  ),
                          ],
                        ),
                        const Divider(
                          color: Colors.deepOrange,
                        ),
                        ...products.map((product) {
                          var decoration = {
                            'color': '#ffffff',
                            'image1Url': '',
                          };

                          product['product']['decorations'].forEach((item) {
                            if (product['decorationId'] == item['_id']) {
                              decoration = {
                                'color': item['color'],
                                'image1Url': item['image1Url'],
                              };
                            }
                          });
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Container(
                                      width: 60,
                                      height: 60,
                                      margin: const EdgeInsets.all(
                                        8,
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.deepOrange,
                                        ),
                                      ),
                                      child: FadeInImage.assetNetwork(
                                        placeholder:
                                            'assets/images/loading.gif',
                                        image: BASE_URL2 +
                                            decoration['image1Url'].toString(),
                                        imageScale: 8,
                                        fit: BoxFit.scaleDown,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(product['product']['name']),
                                        Text(product['product']['model']),
                                        Card(
                                          elevation: 4,
                                          child: CircleAvatar(
                                            radius: 8,
                                            backgroundColor: HexColor(
                                              decoration['color'].toString(),
                                            ),
                                          ),
                                          borderOnForeground: true,
                                        ),
                                        Text('Quantity:' + product['quantity']),
                                        if (product['discountPrice'] != '0')
                                          Text('With Discount: True'.tr() +
                                              product['discountPrice']),
                                        Text(
                                          'Item Price:' +
                                              (int.parse(product['total']) /
                                                      int.parse(
                                                          product['quantity']))
                                                  .toString(),
                                        ),
                                        Text(
                                          'Total Price:' + product['total'],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(
                                indent: 8,
                                endIndent: 8,
                                color: Colors.deepOrange,
                              ),
                            ],
                          );
                        }).toList()
                      ],
                    ),
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
          ).toList(),
        ],
      ),
    );
  }

  static Future<bool> changeShipmentStatusForVendors({
    required BuildContext ctx,
    required String id,
    required String shipmentIndex,
    required String newStatus,
  }) async {
    var _isLoading = false;
    return await showDialog(
      context: ctx,
      builder: (ctx) {
        return AlertDialog(
          content: Text(
              'Do You Want to Check This Shipment as Ready For Shipping ?'.tr(),
              style: Theme.of(ctx).textTheme.subtitle2),
          title: Text(
            'Change Status'.tr(),
          ),
          actions: [
            StatefulBuilder(
              builder: (context, loadingState) {
                if (_isLoading) {
                  return const Padding(
                    padding: EdgeInsets.all(10),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else {
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextButton(
                        onPressed: () async {
                          loadingState(() {
                            _isLoading = true;
                          });
                          await MyServerOrders.changeShipmentStatus(
                            updateMap: {
                              '_id': id,
                              'shipmentIndex': shipmentIndex,
                              'status': newStatus,
                            },
                          ).then((result) {
                            showSnackBar(context: ctx, msg: result);
                            Navigator.pop(context);
                          }).onError((error, stackTrace) {
                            print(stackTrace.toString());
                            showSnackBar(
                              context: ctx,
                              msg: error.toString(),
                            );

                            Navigator.pop(context);
                          });
                        },
                        child: Text(
                          'Check'.tr(),
                        ),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('Cancel'.tr()),
                      ),
                    ],
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }
}

void showSnackBar(
    {required BuildContext context, required String msg, int seconds = 4}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(msg),
      duration: Duration(seconds: seconds),
    ),
  );
}
