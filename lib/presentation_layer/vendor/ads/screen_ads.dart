import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:zohal/constance/strings.dart';
import 'package:zohal/presentation_layer/vendor/ads/card_ad.dart';
import 'package:zohal/presentation_layer/vendor/ads/my_utility.dart';
import 'package:zohal/presentation_layer/vendor/ads/server_ads.dart';
import 'package:zohal/presentation_layer/vendor/ads/util.dart';
import 'package:zohal/presentation_layer/vendor/products/constants.dart';

class VendorAdsScreen extends StatefulWidget {
  // static final routeName = '/web/vendor/ads';

  @override
  _VendorAdsScreenState createState() => _VendorAdsScreenState();
}

class _VendorAdsScreenState extends State<VendorAdsScreen> {
  late Future<List<dynamic>> _getAdsFuture;

  Future<void> _refresh() async {
    setState(() {
      //GET ONLY VENDORS ADS
      _getAdsFuture = MyServerAds.getList(
        null,
      );
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //final auth = Provider.of<Auth>(context, listen: false);

    _getAdsFuture = MyServerAds.getList(
      null,
    );
  }

  Widget _emptyBody() {
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
            'No Ads Found!'.tr(),
          ),
        ],
      ),
    );
  }

  Widget _adsBody() {
    return FutureBuilder<List<dynamic>>(
      future: _getAdsFuture,
      builder: (ctx, adsState) {
        if (adsState.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.grey,
              color: Colors.deepOrange,
            ),
          );
        }

        if (adsState.hasError) {
          return Center(
            child: Text(adsState.error.toString()),
          );
        }
        if (adsState.hasData) {
          final adsList = adsState.data!;

          if (adsList.isEmpty) {
            return _emptyBody();
          }

          return RefreshIndicator(
              onRefresh: (() => _refresh()),
              child: ListView.builder(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                itemCount: adsList.length,
                itemBuilder: (context, index) {
                  final bannerUrl =
                      adsList[index]['bannerUrl'].toString().isNotEmpty
                          ? MyServerConst.BASE_URL +
                              adsList[index]['bannerUrl'] +
                              '?v=${MyUtil.toRefreshImages()}'.toString()
                          : '';

                  return AdCard(
                    bannerUrl: bannerUrl,
                    days: adsList[index]['days'],
                    position: adsList[index]['position'],
                    createdAt: adsList[index]['createdAt'],
                    expiresAt: adsList[index]['expiresAt'],
                    status: adsList[index]['status'],
                    vendor: null,
                    editCallback: null,
                    deleteCallback: null,
                    statusCallback: null,
                  );
                },
              ));
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          label: Text(
            lang == 'EN' ? 'Add' : '',
          ),
          icon: const Icon(Icons.add),
          onPressed: () {
            AdsUtil.showVendorAdDialog(
              context,
              {
                'isAdding': true,
                'bannerUrl': '',
                'position': '',
                'days': '',
                'vendorId': userId,
              },
            ).then((hasAdded) {
              if (hasAdded) {
                _refresh();
              }
            });
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: SafeArea(child: _adsBody()),
    );
  }
}
