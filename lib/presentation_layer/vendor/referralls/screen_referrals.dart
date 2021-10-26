import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:zohal/presentation_layer/vendor/active_order/card_shipment.dart';
import 'package:zohal/presentation_layer/vendor/products/constants.dart';
import 'package:zohal/presentation_layer/vendor/products/server_vendors.dart';
import 'package:zohal/presentation_layer/vendor/referralls/round_fade_image.dart';

class VendorReferralsScreen extends StatefulWidget {
  // static final routeName = '/web/vendor/referrals';

  @override
  _VendorReferralsScreenState createState() => _VendorReferralsScreenState();
}

class _VendorReferralsScreenState extends State<VendorReferralsScreen> {
  late Future<Map<String, dynamic>> _getReferralsFuture;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _getReferralsFuture = MyServerVendors.getReferrals();
  }

  Widget _vendorsBody(List<dynamic> vendorsList, String percent) {
    if (vendorsList.isEmpty) {
      return Column(
        children: [
          Text(
            'Vendors'.tr(),
            style: Theme.of(context).textTheme.headline6,
          ),
          const Spacer(),
          Center(
            child: Wrap(
              direction: Axis.vertical,
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                const SizedBox(
                  height: 24,
                ),
                const Icon(
                  FontAwesomeIcons.listAlt,
                  size: 64,
                  color: Colors.grey,
                ),
                const SizedBox(
                  height: 32,
                ),
                Text(
                  'No Vendors Referred!'.tr(),
                ),
              ],
            ),
          ),
          const Spacer(),
        ],
      );
    }

    return Column(
      children: [
        Text(
          'Vendors'.tr(),
          style: Theme.of(context).textTheme.headline6,
        ),
        ListView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.only(
            top: 10,
            bottom: 10,
            right: 5,
            left: 5,
          ),
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          itemCount: vendorsList.length,
          itemBuilder: (ctx, index) {
            final photoUrl =
                vendorsList[index]['photoUrl'].toString().isNotEmpty
                    ? MyServerConst.BASE_URL + vendorsList[index]['photoUrl']
                    : '';

            return Card(
              margin: const EdgeInsets.symmetric(
                vertical: 8,
              ),
              elevation: 4,
              child: ListTile(
                  leading: RoundedFadeImage(
                    photoUrl: photoUrl,
                    radius: 28,
                  ),
                  title: Text(
                    vendorsList[index]['firstName'] +
                        ' ' +
                        vendorsList[index]['lastName'],
                  ),
                  subtitle: Text(vendorsList[index]['email']),
                  trailing: Text(
                    '% $percent',
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          color: Colors.green,
                        ),
                  )),
            );
          },
        ),
      ],
    );
  }

  Widget _customersBody(
    List<dynamic> customersList,
    String pointsValue,
  ) {
    if (customersList.isEmpty) {
      return Column(
        children: [
          Text(
            'Customers'.tr(),
            style: Theme.of(context).textTheme.headline6,
          ),
          const Spacer(),
          Center(
            child: Wrap(
              direction: Axis.vertical,
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                const SizedBox(
                  height: 24,
                ),
                const Icon(
                  FontAwesomeIcons.listAlt,
                  size: 64,
                  color: Colors.grey,
                ),
                const SizedBox(
                  height: 32,
                ),
                Text(
                  'No Customers Referred!'.tr(),
                ),
              ],
            ),
          ),
          const Spacer(),
        ],
      );
    }

    return Column(
      children: [
        Text(
          'Customers'.tr(),
          style: Theme.of(context).textTheme.headline6,
        ),
        ListView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.only(
            top: 10,
            bottom: 10,
            right: 5,
            left: 5,
          ),
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          itemCount: customersList.length,
          itemBuilder: (ctx, index) {
            final photoUrl =
                customersList[index]['photoUrl'].toString().isNotEmpty
                    ? MyServerConst.BASE_URL + customersList[index]['photoUrl']
                    : '';

            return Card(
              margin: const EdgeInsets.symmetric(
                vertical: 8,
              ),
              elevation: 4,
              child: ListTile(
                  leading: RoundedFadeImage(
                    photoUrl: photoUrl,
                    radius: 28,
                  ),
                  title: Text(
                    customersList[index]['firstName'] +
                        ' ' +
                        customersList[index]['lastName'],
                  ),
                  subtitle: Text(customersList[index]['email']),
                  trailing: Text(
                    '+ $pointsValue',
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          color: Colors.green,
                        ),
                  )),
            );
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
          body: FutureBuilder<Map<String, dynamic>>(
        future: _getReferralsFuture,
        builder: (ctx, referralsState) {
          if (referralsState.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (referralsState.hasError) {
            return Center(
              child: Text(referralsState.error.toString()),
            );
          }

          if (referralsState.hasData) {
            final referralsData = referralsState.data!;

            return Column(
              children: [
                Flexible(
                  flex: 2,
                  child: Card(
                    margin: const EdgeInsets.all(
                      8,
                    ),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          48,
                        ),
                      ),
                    ),
                    elevation: 4,
                    color: theme.primaryColor,
                    child: InkWell(
                      onTap: () {
                        Clipboard.setData(
                          ClipboardData(
                            text: referralsData['referCode'].toString(),
                          ),
                        ).then((_) => showSnackBar(
                              context: context,
                              msg: 'Code Copied to Clipboard'.tr(),
                            ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(
                          8,
                        ),
                        child: Row(
                          children: [
                            const CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 32,
                              child: Icon(
                                Icons.compare_arrows_rounded,
                                size: 32,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              'Your Referral Code\n${referralsData['referCode']}',
                              textAlign: TextAlign.center,
                              style: theme.textTheme.caption?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 8,
                  fit: FlexFit.loose,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        Expanded(
                          child: _vendorsBody(
                            referralsData['vendors'],
                            referralsData['vendorReferralPercent'].toString(),
                          ),
                        ),
                        VerticalDivider(
                          indent: 12,
                          endIndent: 12,
                          thickness: 2,
                          color: theme.colorScheme.primary,
                        ),
                        Expanded(
                          child: Container(
                            child: _customersBody(
                              referralsData['customers'],
                              referralsData['customerReferralPoints']
                                  .toString(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      )),
    );
  }
}
