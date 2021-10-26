import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zohal/presentation_layer/vendor/active_order/card_shipment.dart';
import 'package:zohal/presentation_layer/vendor/active_order/server_order.dart';

class VendorActiveOrder extends StatefulWidget {
  //static final routeName = '/web/vendor/orders';

  @override
  _WebVendorOrdersState createState() => _WebVendorOrdersState();
}

class _WebVendorOrdersState extends State<VendorActiveOrder>
    with TickerProviderStateMixin {
  late Future<List<dynamic>> _getActiveOrdersFuture;

  late Future<List<dynamic>> _getOrdersHistoryFuture;

  late TabController _tabController;

  Future<void> _refresh() async {
    setState(() {
      _getActiveOrdersFuture = MyServerOrders.getVendorActiveList();

      _getOrdersHistoryFuture = MyServerOrders.getVendorHistoryList();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
   

    _getActiveOrdersFuture = MyServerOrders.getVendorActiveList();

    _getOrdersHistoryFuture = MyServerOrders.getVendorHistoryList();

    _tabController = TabController(
      length: 2,
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  Widget _emptyBody() {
    return Center(
      child: Wrap(
        direction: Axis.vertical,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          const Icon(
            FontAwesomeIcons.cartArrowDown,
            size: 64,
            color: Colors.blue,
          ),
          const SizedBox(
            height: 32,
          ),
          Text(
             'No Orders Found!'.tr(),
          ),
        ],
      ),
    );
  }

  Widget _activeBody() {
    return FutureBuilder<List<dynamic>>(
      future: _getActiveOrdersFuture,
      builder: (ctx, ordersState) {
        if (ordersState.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (ordersState.hasError) {
          return Center(
            child: Text(ordersState.error.toString()),
          );
        }

        if (ordersState.hasData) {
          final ordersList = ordersState.data!;

          if (ordersList.isEmpty) {
            return _emptyBody();
          }

          return RefreshIndicator(
            onRefresh: () => _refresh(),
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              itemCount: ordersList.length,
              itemBuilder: (context, index) {
                return ShipmentCard(
                  
                  id: ordersList[index]['_id'],
                  isExpanded: true,
                  createdAt: ordersList[index]['createdAt'],
                  customer: ordersList[index]['customer'],
                  coupon: ordersList[index]['coupon'],
                  shipments: ordersList[index]['shipments'],
                  refreshCallback: () => _refresh(),
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

  Widget _historyBody() {
    return FutureBuilder<List<dynamic>>(
      future: _getOrdersHistoryFuture,
      builder: (ctx, ordersState) {
        if (ordersState.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(backgroundColor: Colors.grey,color: Colors.deepOrange,)
          );
        }

        if (ordersState.hasError) {
          return Center(
            child: Text(ordersState.error.toString()),
          );
        }

        if (ordersState.hasData) {
          final ordersList = ordersState.data!;

          if (ordersList.isEmpty) {
            return _emptyBody();
          }

          return RefreshIndicator(
            onRefresh: () => _refresh(),
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              itemCount: ordersList.length,
              itemBuilder: (context, index) {
                return ShipmentCard(
                  
                  id: ordersList[index]['_id'],
                  isExpanded: false,
                  createdAt: ordersList[index]['createdAt'],
                  customer: ordersList[index]['customer'],
                  coupon: ordersList[index]['coupon'],
                  shipments: ordersList[index]['shipments'],
                  refreshCallback: () => _refresh(),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SafeArea(
        child:  Column(
            children: [
              TabBar(
                labelPadding: const EdgeInsets.all(12),
                labelStyle: Theme.of(context).textTheme.headline6?.copyWith(
                  color: Colors.white,
                ),
                automaticIndicatorColorAdjustment: true,
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: Colors.red,
                controller: _tabController,
                tabs: [
                  Text(
                    'Active Orders'.tr() ,
                  ),
                  Text('الطلبات السابقة'.tr(),
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _activeBody(),
                    _historyBody(),
                  ],
                ),
              ),
            ],
          ),
        ),
  
    );
  }
}