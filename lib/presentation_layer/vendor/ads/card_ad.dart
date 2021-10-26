import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zohal/constance/strings.dart';
import 'package:zohal/presentation_layer/vendor/ads/my_utility.dart';

class AdCard extends StatelessWidget {
  AdCard({
    required String bannerUrl,
    required String days,
    String? position,
    required String createdAt,
    String? expiresAt,
    required String status,
    required Map<String, dynamic>? vendor,
    required Function? editCallback,
    required Function? deleteCallback,
    required Function? statusCallback,
  })  : _bannerUrl = bannerUrl,
        _days = days,
        _position = position,
        _createdAt = createdAt,
        _expiresAt = expiresAt,
        _status = status,
        _vendor = vendor,
        _editCallback = editCallback,
        _deleteCallback = deleteCallback,
        _statusCallback = statusCallback;

  final String _bannerUrl;
  final String _days;
  final String? _position;
  final String _createdAt;
  final String? _expiresAt;
  final String _status;
  final Map<String, dynamic>? _vendor;
  final Function? _editCallback;
  final Function? _deleteCallback;
  final Function? _statusCallback;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: SizedBox(
        height: 200,
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  _bannerUrl.isEmpty
                      ? const Center(
                          child: Icon(
                            FontAwesomeIcons.ad,
                            color: Colors.white,
                            size: 25,
                          ),
                        )
                      : FadeInImage(
                          width: MediaQuery.of(context).size.width,
                          height: 200,
                          fit: BoxFit.cover,
                          placeholder: const AssetImage(
                            'assets/images/loading.gif',
                          ),
                          image: NetworkImage(
                            _bannerUrl,
                          ),
                          imageErrorBuilder: (context, error, stackTrace) =>
                              const Icon(
                            Icons.broken_image_outlined,
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          'Position:'.tr() +
                              MyUtil.getAdPosition(_position.toString(), true),
                          textAlign: TextAlign.start,
                          style: Theme.of(context).textTheme.caption,
                        ),
                        Text(
                          'Days:' + _days,
                          textAlign: TextAlign.start,
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        if (_expiresAt != null)
                          Text(
                            'Expires At:'.tr() +
                                MyUtil.formatDate(_expiresAt!, true),
                            textAlign: TextAlign.start,
                            style: Theme.of(context).textTheme.caption,
                          ),
                        Text(
                          'Created At:'.tr() +
                              MyUtil.formatDate(_createdAt, true),
                          textAlign: TextAlign.start,
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          tooltip: _status == '0'
                              ? lang == 'EN'
                                  ? 'Pending'
                                  : 'تحت المراجعة'
                              : _status == '1'
                                  ? lang == 'EN'
                                      ? 'Approved'
                                      : 'مسموح'
                                  : lang == 'EN'
                                      ? 'Banned'
                                      : 'مرفوض',
                          onPressed: () async => _statusCallback != null
                              ? _statusCallback!()
                              : null,
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
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
