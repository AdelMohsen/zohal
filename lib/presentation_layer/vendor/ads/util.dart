import 'dart:typed_data';

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zohal/constance/strings.dart';
import 'package:zohal/presentation_layer/vendor/active_order/card_shipment.dart';
import 'package:zohal/presentation_layer/vendor/ads/item_image_picker.dart';
import 'package:zohal/presentation_layer/vendor/ads/server_ads.dart';

class AdsUtil {
  static String _vendorId = '';
  static String _days = '';
  static String _position = '';
  static Uint8List? _imageBytes;
  static String _fileName = '';
  static String _fileMime = '';
  static var _isLoading = false;

  static Future<bool> _onAction(
    BuildContext ctx,
    Map<String, dynamic> dialogMap,
  ) async {
    if (dialogMap['isAdding']) {
      return await MyServerAds.addAd(
        vendorId: _vendorId,
        days: _days,
        position: _position,
        imageBytes: _imageBytes,
        fileName: _fileName,
        fileMime: _fileMime,
      ).then((result) {
        imageCache?.clear();
        _imageBytes = null;
        _fileMime = '';
        _fileName = '';
        showSnackBar(context: ctx, msg: result);
        return true;
      }).onError((error, stackTrace) {
        print(stackTrace.toString());
        imageCache?.clear();
        _imageBytes = null;
        _fileMime = '';
        _fileName = '';
        showSnackBar(context: ctx, msg: error.toString());
        return false;
      });
    } else {
      final Map<String, dynamic> updateMap = {
        '_id': dialogMap['id'],
      };

      Map<String, dynamic>? imageMap;

      if (dialogMap['days'] != _days) updateMap['days'] = _days;
      if (dialogMap['position'] != _position) updateMap['position'] = _position;
      if (dialogMap['vendorId'] != _vendorId) updateMap['vendorId'] = _vendorId;

      if (_imageBytes != null) {
        imageMap = {
          'imageBytes': _imageBytes,
          'fileName': _fileName,
          'fileMime': _fileMime,
        };
      }

      if (updateMap.length == 1 && imageMap == null) return false;

      return await MyServerAds.updateAd(
        updateMap: updateMap,
        imageMap: imageMap,
      ).then((result) {
        _imageBytes = null;
        _fileMime = '';
        _fileName = '';
        showSnackBar(context: ctx, msg: result);
        return true;
      }).onError((error, stackTrace) {
        print(stackTrace.toString());
        _imageBytes = null;
        _fileMime = '';
        _fileName = '';
        showSnackBar(context: ctx, msg: error.toString());
        return false;
      });
    }
  }

  static Future<bool> changeAdStatus({
    required BuildContext ctx,
    required String id,
    required String status,
  }) async {
    return await showDialog(
      context: ctx,
      builder: (ctx) {
        _isLoading = false;
        return AlertDialog(
          content: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                'Current Status: '.tr(),
                style: Theme.of(ctx).textTheme.subtitle2,
              ),
              Text(
                status == '0'
                    ? lang == 'EN'
                        ? 'Pending'
                        : 'تحت المراجعة'
                    : status == '1'
                        ? lang == 'EN'
                            ? 'Allowed'
                            : 'مسموح'
                        : lang == 'EN'
                            ? 'Banned'
                            : 'مرفوض',
                style: Theme.of(ctx).textTheme.caption,
              ),
            ],
          ),
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
                          if (status == '1') {
                            Navigator.pop(context);
                          } else {
                            loadingState(() {
                              _isLoading = true;
                            });
                            await MyServerAds.updateAd(
                              updateMap: {
                                '_id': id,
                                'status': '1',
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
                          }
                        },
                        child: Text(
                          'Allow'.tr(),
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          if (status == '-1') {
                            Navigator.pop(context);
                          } else {
                            loadingState(() {
                              _isLoading = true;
                            });
                            await MyServerAds.updateAd(
                              updateMap: {
                                '_id': id,
                                'status': '-1',
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
                          }
                        },
                        child: Text(
                          'Ban'.tr(),
                        ),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          'CANCEL'.tr(),
                        ),
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

  static Future<bool> deleteAd(
    BuildContext ctx,
    String id,
  ) async {
    return await showDialog(
      context: ctx,
      builder: (ctx) {
        _isLoading = false;
        return AlertDialog(
          content: Text(
            'This is Permenant, Are You Sure You Want to Procced ?'.tr(),
          ),
          title: Text('Delete Ad'.tr()),
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
                          await MyServerAds.deleteAd(
                            id: id,
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
                          'DELETE'.tr(),
                        ),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          'CANCEL'.tr(),
                        ),
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

  static Future<bool> showAdDialog(
    BuildContext ctx,
    Map<String, dynamic> dialogMap,
  ) async {
    _isLoading = false;
    final _formKey = GlobalKey<FormState>();
    final List<Map<String, dynamic>> vendorsList = [];
    final positionList = lang == 'EN'
        ? [
            'Top',
            'Middle',
            'Bottom',
          ]
        : [
            'في الأعلي',
            'في الوسط',
            'في الأسفل',
          ];

    dialogMap['vendorsList'].forEach((vendor) {
      vendorsList.add({
        '_id': vendor['_id'],
        'company': vendor['company'],
      });
    });

    if (!dialogMap['isAdding']) _vendorId = dialogMap['vendorId'];

    return await showDialog(
      barrierDismissible: false,
      context: ctx,
      builder: (ctx) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            title: Text(
              dialogMap['isAdding']
                  ? lang == 'EN'
                      ? 'Add Ad'
                      : 'إضافة إعلان'
                  : lang == 'EN'
                      ? 'Edit Ad'
                      : 'تعديل الإعلان',
            ),
            content: SingleChildScrollView(
              child: SizedBox(
                width: 200,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ItemImagePicker(
                        photoUrl: dialogMap['bannerUrl'],
                        language: lang.toString(),
                        hasFullWidth: true,
                        isUser: false,
                        setFileCallBack: (bytes, name, mime) {
                          _imageBytes = bytes;
                          _fileName = name;
                          _fileMime = mime;
                        }),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            initialValue: dialogMap['days'],
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            decoration: InputDecoration(
                              labelText: 'Days'.tr(),
                            ),
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a valid Number'.tr();
                              }
                            },
                            onSaved: (value) {
                              _days = value.toString();
                            },
                          ),
                          DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              labelText: 'Choose Position'.tr(),
                            ),
                            validator: (position) {
                              if (position == null || position.isEmpty) {
                                return 'Please Select a Valid Position';
                              }
                            },
                            items: positionList.map((position) {
                              return DropdownMenuItem(
                                child: Text(
                                  position,
                                ),
                                value: position,
                              );
                            }).toList(),
                            onChanged: dialogMap['isAdding']
                                ? (position) {
                                    _position = positionList
                                        .indexOf(position.toString())
                                        .toString();
                                  }
                                : null,
                            value: dialogMap['isAdding']
                                ? null
                                : positionList[int.parse(
                                    dialogMap['position'],
                                  )],
                          ),
                          DropdownButtonFormField(
                            decoration: InputDecoration(
                              labelText: 'Choose Vendor'.tr(),
                            ),
                            validator: (vendor) {
                              if (vendor == null) {
                                return 'Please Select a Valid Vendor'.tr();
                              }
                            },
                            items: vendorsList.map((vendor) {
                              return DropdownMenuItem(
                                child: Text(
                                  vendor['company'],
                                ),
                                value: vendor,
                              );
                            }).toList(),
                            onChanged: dialogMap['isAdding']
                                ? (vendor) {
                                    final ven = vendor! as Map<String, dynamic>;
                                    _vendorId = ven['_id'];
                                  }
                                : null,
                            value: dialogMap['isAdding']
                                ? null
                                : vendorsList.singleWhere(
                                    (vendor) =>
                                        vendor['_id'] == dialogMap['vendorId'],
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
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
                            _formKey.currentState?.save();

                            if (_formKey.currentState != null &&
                                _formKey.currentState!.validate()) {
                              loadingState(() {
                                _isLoading = true;
                              });

                              final hasAction = await _onAction(
                                ctx,
                                dialogMap,
                              );

                              Navigator.pop(context);
                            } else {
                              loadingState(() {
                                _isLoading = false;
                              });
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                            ),
                            child: Text(
                              dialogMap['isAdding']
                                  ? lang == 'EN'
                                      ? 'ADD'
                                      : 'إضافة'
                                  : lang == 'EN'
                                      ? 'SAVE'
                                      : 'حفظ',
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'CANCEL'.tr(),
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  static Future<bool> showVendorAdDialog(
    BuildContext ctx,
    Map<String, dynamic> dialogMap,
  ) async {
    _vendorId = dialogMap['vendorId'];
    _isLoading = false;
    final _formKey = GlobalKey<FormState>();

    final positionList = lang == 'EN'
        ? [
            'Top',
            'Middle',
            'Bottom',
          ]
        : [
            'في الأعلي',
            'في الوسط',
            'في الأسفل',
          ];

    return await showDialog(
      barrierDismissible: false,
      context: ctx,
      builder: (ctx) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            title: Text('Add Ad'.tr()),
            content: SingleChildScrollView(
              child: SizedBox(
                width: 200,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ItemImagePicker(
                        photoUrl: dialogMap['bannerUrl'],
                        language: lang.toString(),
                        hasFullWidth: true,
                        isUser: false,
                        setFileCallBack: (bytes, name, mime) {
                          _imageBytes = bytes;
                          _fileName = name;
                          _fileMime = mime;
                        }),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            initialValue: dialogMap['days'],
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            decoration: InputDecoration(
                              labelText: 'Days'.tr(),
                            ),
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a valid Number'.tr();
                              }
                            },
                            onSaved: (value) {
                              _days = value.toString();
                            },
                          ),
                          DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              labelText: 'Choose Position'.tr(),
                            ),
                            validator: (position) {
                              if (position == null || position.isEmpty) {
                                return 'Please Select a Valid Position'.tr();
                              }
                            },
                            items: positionList.map((position) {
                              return DropdownMenuItem(
                                child: Text(
                                  position,
                                ),
                                value: position,
                              );
                            }).toList(),
                            onChanged: dialogMap['isAdding']
                                ? (position) {
                                    _position = positionList
                                        .indexOf(position.toString())
                                        .toString();
                                  }
                                : null,
                            value: dialogMap['isAdding']
                                ? null
                                : positionList[int.parse(
                                    dialogMap['position'],
                                  )],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
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
                            _formKey.currentState?.save();

                            if (_formKey.currentState != null &&
                                _formKey.currentState!.validate()) {
                              loadingState(() {
                                _isLoading = true;
                              });

                              final hasAction = await _onAction(
                                ctx,
                                dialogMap,
                              );

                              Navigator.pop(context);
                            } else {
                              loadingState(() {
                                _isLoading = false;
                              });
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                            ),
                            child: Text('ADD'.tr()),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'CANCEL'.tr(),
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
