import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zohal/constance/strings.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    required String name,
    required String arabicName,
    required String model,
    required String price,
    required String discountPrice,
    required String status,
    required String hasSizes,
    required Map<String, dynamic> vendor,
    required Function editCallback,
    required Function? deleteCallback,
    required Function sizesCallback,
    required Function discountCallback,
    required Function decorationsCallback,
    required Function historyCallback,
    required Function? statusCallback,
  })  : _name = name,
        _arabicName = arabicName,
        _model = model,
        _price = price,
        _discountPrice = discountPrice,
        _status = status,
        _hasSizes = hasSizes,
        _vendor = vendor,
        _editCallback = editCallback,
        _deleteCallback = deleteCallback,
        _sizesCallback = sizesCallback,
        _discountCallback = discountCallback,
        _decorationsCallback = decorationsCallback,
        _historyCallback = historyCallback,
        _statusCallback = statusCallback,
        super(key: key);

  final String _name;
  final String _arabicName;
  final String _model;
  final String _price;
  final String _discountPrice;
  final String _status;
  final String _hasSizes;
  final Map<String, dynamic> _vendor;
  final Function _editCallback;
  final Function? _deleteCallback;
  final Function _discountCallback;
  final Function _sizesCallback;
  final Function _decorationsCallback;
  final Function _historyCallback;
  final Function? _statusCallback;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      elevation: 4,
      child: ListTile(
        leading: const CircleAvatar(
          radius: 28,
          child: Icon(
            Icons.list_alt_outlined,
          ),
        ),
        title: Text(
          lang == 'EN' ? _name : _arabicName,
        ),
        subtitle: Column(
          children: [
            Text(
              ('Model:'.tr() + _model + 'Company:'.tr() + _vendor['company']),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () async => _editCallback(),
                  icon: const Icon(
                    Icons.edit,
                  ),
                ),
                IconButton(
                  tooltip: 'Price:'.tr() +
                      _price +
                      '\n' +
                      'Discount:'.tr() +
                      _discountPrice,
                  onPressed: () async =>
                      _status == '1' ? _discountCallback() : null,
                  icon: Icon(
                    FontAwesomeIcons.percentage,
                    color: _discountPrice == '0' ? Colors.grey : Colors.green,
                  ),
                ),
                IconButton(
                  tooltip: lang == 'EN'
                      ? 'Status: ${_status == '1' ? 'Approved' : _status == '0' ? 'Pending' : 'Rejected'}'
                      : 'الحالة: ${_status == '1' ? 'مقبول' : _status == '0' ? 'تحت المراجعة' : 'مرفوض'}',
                  onPressed: null,
                  icon: Icon(
                    _status == '1'
                        ? Icons.check_box_outlined
                        : _status == '0'
                            ? Icons.indeterminate_check_box_outlined
                            : Icons.remove_from_queue_outlined,
                    color: _status == '1'
                        ? Colors.green
                        : _status == '0'
                            ? Colors.amber
                            : Colors.redAccent,
                  ),
                ),
                if (_status == '1')
                  PopupMenuButton(
                    icon: const Icon(
                      Icons.more_vert_outlined,
                    ),
                    itemBuilder: (context) {
                      final pList = lang == 'EN'
                          ? _hasSizes == '1'
                              ? [
                                  'Decorations',
                                  'Sizes',
                                ]
                              : [
                                  'Decorations',
                                ]
                          : _hasSizes == '1'
                              ? [
                                  'المظهر',
                                  'الأحجام',
                                ]
                              : [
                                  'المظهر',
                                ];

                      return pList.map((String value) {
                        return PopupMenuItem(
                          value: value,
                          child: Text(value),
                        );
                      }).toList();
                    },
                    onSelected: (selectedItem) {
                      if (selectedItem == 'Decorations' ||
                          selectedItem == 'المظهر') {
                        _decorationsCallback();
                      } else {
                        _sizesCallback();
                      }
                    },
                  ),
              ],
            ),
          ],
        ),
        isThreeLine: true,
      ),
    );
  }
}
