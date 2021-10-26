import 'dart:typed_data';

import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zohal/constance/strings.dart';
import 'package:zohal/presentation_layer/vendor/active_order/card_shipment.dart';
import 'package:zohal/presentation_layer/vendor/products/product_image_picker.dart';
import 'package:zohal/presentation_layer/vendor/products/server_products.dart';

class ProductsUtil {
  static String _name = '';
  static String _arabicName = '';
  static String _model = '';
  static String _price = '';
  static String _discountPrice = '';
  static String _description = '';
  static String _inStock = '';
  static String _hasSizes = '';
  static String _brandId = '';
  static String _categoryId = '';
  static String _sectionId = '';
  static String _subSectionId = '';
  static String _vendorId = '';
  static String _color = '';
  static String _sizeName = '';

  static Uint8List? _imageBytes1;
  static String _fileName1 = '';
  static String _fileMime1 = '';

  static Uint8List? _imageBytes2;
  static String _fileName2 = '';
  static String _fileMime2 = '';

  static Uint8List? _imageBytes3;
  static String _fileName3 = '';
  static String _fileMime3 = '';

  static Uint8List? _imageBytes4;
  static String _fileName4 = '';
  static String _fileMime4 = '';

  static var _isLoading = false;

  static Future<bool> _onAction(
    BuildContext ctx,
    Map<String, dynamic> dialogMap,
  ) async {
    if (dialogMap['isAdding']) {
      return await MyServerProducts.addProduct(
        name: _name,
        arabicName: _arabicName,
        model: _model,
        price: _price,
        description: _description,
        inStock: _inStock,
        hasSizes: _hasSizes,
        brandId: _brandId,
        categoryId: _categoryId,
        sectionId: _sectionId,
        subSectionId: _subSectionId,
        vendorId: _vendorId,
      ).then((result) {
        imageCache?.clear();
        showSnackBar(context: ctx, msg: result);
        return true;
      }).onError((error, stackTrace) {
        print(stackTrace.toString());
        imageCache?.clear();
        showSnackBar(context: ctx, msg: error.toString());
        return false;
      });
    } else {
      final Map<String, dynamic> updateMap = {
        '_id': dialogMap['id'],
        'oldSubSectionId': dialogMap['subSectionId'],
        'oldBrandId': dialogMap['brandId'],
      };

      if (dialogMap['name'] != _name) updateMap['name'] = _name;
      if (dialogMap['arabicName'] != _arabicName)
        updateMap['arabicName'] = _arabicName;
      if (dialogMap['model'] != _model) updateMap['model'] = _model;
      if (dialogMap['price'] != _price) updateMap['price'] = _price;
      if (dialogMap['description'] != _description)
        updateMap['description'] = _description;

      if (dialogMap['inStock'] != _inStock) updateMap['inStock'] = _inStock;
      if (dialogMap['brandId'] != _brandId) updateMap['brandId'] = _brandId;

      if (dialogMap['subSectionId'] != _subSectionId)
        updateMap['subSectionId'] = _subSectionId;

      if (dialogMap['vendorId'] != _vendorId) updateMap['vendorId'] = _vendorId;

      if (updateMap.length == 3) return false;

      return await MyServerProducts.updateProduct(
        updateMap: updateMap,
      ).then((result) {
        showSnackBar(context: ctx, msg: result);
        return true;
      }).onError((error, stackTrace) {
        print(stackTrace.toString());
        showSnackBar(context: ctx, msg: error.toString());
        return false;
      });
    }
  }

  static Future<bool> _onDecorAction(
    BuildContext ctx,
    Map<String, dynamic> dialogMap,
  ) async {
    if (dialogMap['isAdding']) {
      return await MyServerProducts.addDecor(
        color: _color,
        id: dialogMap['id'],
        imageBytes1: _imageBytes1,
        fileName1: _fileName1,
        fileMime1: _fileMime1,
        imageBytes2: _imageBytes2,
        fileName2: _fileName2,
        fileMime2: _fileMime2,
        imageBytes3: _imageBytes3,
        fileName3: _fileName3,
        fileMime3: _fileMime3,
        imageBytes4: _imageBytes4,
        fileName4: _fileName4,
        fileMime4: _fileMime4,
      ).then((result) {
        imageCache?.clear();
        _imageBytes1 = null;
        _fileMime1 = '';
        _fileName1 = '';
        _imageBytes2 = null;
        _fileMime2 = '';
        _fileName2 = '';
        _imageBytes3 = null;
        _fileMime3 = '';
        _fileName3 = '';
        _imageBytes4 = null;
        _fileMime4 = '';
        _fileName4 = '';
        showSnackBar(context: ctx, msg: result);
        return true;
      }).onError((error, stackTrace) {
        print(stackTrace.toString());
        imageCache?.clear();
        _imageBytes1 = null;
        _fileMime1 = '';
        _fileName1 = '';
        _imageBytes2 = null;
        _fileMime2 = '';
        _fileName2 = '';
        _imageBytes3 = null;
        _fileMime3 = '';
        _fileName3 = '';
        _imageBytes4 = null;
        _fileMime4 = '';
        _fileName4 = '';
        showSnackBar(context: ctx, msg: error.toString());
        return false;
      });
    } else {
      final Map<String, dynamic> updateMap = {
        '_id': dialogMap['id'],
        'decorId': dialogMap['decorId'],
      };

      updateMap['color'] = _color;

      if (_imageBytes1 != null) {
        updateMap['image1'] = {
          'imageBytes1': _imageBytes1,
          'fileName1': _fileName1,
          'fileMime1': _fileMime1,
        };
      }

      if (_imageBytes2 != null) {
        updateMap['image2'] = {
          'imageBytes2': _imageBytes2,
          'fileName2': _fileName2,
          'fileMime2': _fileMime2,
        };
      }

      if (_imageBytes3 != null) {
        updateMap['image3'] = {
          'imageBytes3': _imageBytes3,
          'fileName3': _fileName3,
          'fileMime3': _fileMime3,
        };
      }

      if (_imageBytes4 != null) {
        updateMap['image4'] = {
          'imageBytes4': _imageBytes4,
          'fileName4': _fileName4,
          'fileMime4': _fileMime4,
        };
      }

      if (updateMap.length == 1) return false;

      return await MyServerProducts.updateDecor(
        updateMap: updateMap,
      ).then((result) {
        showSnackBar(context: ctx, msg: result);
        _imageBytes1 = null;
        _fileMime1 = '';
        _fileName1 = '';
        _imageBytes2 = null;
        _fileMime2 = '';
        _fileName2 = '';
        _imageBytes3 = null;
        _fileMime3 = '';
        _fileName3 = '';
        _imageBytes4 = null;
        _fileMime4 = '';
        _fileName4 = '';
        return true;
      }).onError((error, stackTrace) {
        print(stackTrace.toString());
        showSnackBar(context: ctx, msg: error.toString());
        _imageBytes1 = null;
        _fileMime1 = '';
        _fileName1 = '';
        _imageBytes2 = null;
        _fileMime2 = '';
        _fileName2 = '';
        _imageBytes3 = null;
        _fileMime3 = '';
        _fileName3 = '';
        _imageBytes4 = null;
        _fileMime4 = '';
        _fileName4 = '';
        return false;
      });
    }
  }

  static Future<bool> discountProduct(
    BuildContext ctx,
    String id,
    String price,
    String discountPrice,
  ) async {
    _isLoading = false;
    final _formKey = GlobalKey<FormState>();

    return await showDialog(
      context: ctx,
      builder: (ctx) {
        return AlertDialog(
          content: Form(
            key: _formKey,
            child: TextFormField(
              initialValue: discountPrice == '0' ? '' : discountPrice,
              decoration: InputDecoration(
                labelText: 'Discount Price'.tr(),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value == null ||
                    value.isEmpty ||
                    int.parse(value) >= int.parse(price)) {
                  return 'Please enter a valid Discount'.tr();
                }
              },
              onSaved: (value) {
                _discountPrice = value.toString();
              },
            ),
          ),
          title: Text(discountPrice == '0'
              ? 'Add'.tr()
              : 'Change'.tr() + 'Discount'.tr()),
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
                          if (_formKey.currentState != null &&
                              _formKey.currentState!.validate()) {
                            _formKey.currentState?.save();
                            loadingState(() {
                              _isLoading = true;
                            });
                            await MyServerProducts.updateProduct(
                              updateMap: {
                                '_id': id,
                                'discountPrice': _discountPrice,
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
                          discountPrice == '0' ? 'ADD'.tr() : 'CHANGE'.tr(),
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

  static Future<bool> deleteDecor(
    BuildContext ctx,
    String productId,
    String decorId,
  ) async {
    return await showDialog(
      context: ctx,
      builder: (ctx) {
        _isLoading = false;
        return AlertDialog(
          content: Text(
            'This is Permenant, Are You Sure You Want to Procced ?'.tr(),
          ),
          title: Text('Delete Decoration'.tr()),
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
                          await MyServerProducts.deleteDecor(
                            productId: productId,
                            decorId: decorId,
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

  static Future<bool> deleteSize({
    required BuildContext ctx,
    required int index,
    required String id,
  }) async {
    return await showDialog(
      context: ctx,
      builder: (ctx) {
        _isLoading = false;
        return AlertDialog(
          content: Text(
              'This is Permenant, Are You Sure You Want to Procced ?'.tr()),
          title: Text('Delete Size'.tr()),
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
                          await MyServerProducts.deleteSize(
                            index: index,
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
                        child: Text('CANCEL'.tr()),
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

  static Future<bool> _onSizeAction(
    BuildContext ctx,
    Map<String, dynamic> dialogMap,
  ) async {
    if (dialogMap['isAdding']) {
      return await MyServerProducts.addSize(
        id: dialogMap['_id'],
        name: _sizeName,
      ).then((result) {
        showSnackBar(context: ctx, msg: result, seconds: 1);
        return true;
      }).onError((error, stackTrace) {
        print(stackTrace.toString());
        showSnackBar(context: ctx, msg: error.toString());
        return false;
      });
    } else {
      final Map<String, dynamic> updateMap = {
        '_id': dialogMap['_id'],
        'index': dialogMap['index'],
      };

      if (dialogMap['name'] != _sizeName) updateMap['name'] = _sizeName;

      if (updateMap.length == 1) return false;

      return await MyServerProducts.updateSize(
        updateMap: updateMap,
      ).then((result) {
        showSnackBar(context: ctx, msg: result);
        return true;
      }).onError((error, stackTrace) {
        print(stackTrace.toString());
        showSnackBar(context: ctx, msg: error.toString());
        return false;
      });
    }
  }

  static Future<bool> showSizeDialog(
    BuildContext ctx,
    Map<String, dynamic> dialogMap,
  ) async {
    _isLoading = false;
    final _formKey = GlobalKey<FormState>();

    return await showDialog(
      barrierDismissible: false,
      context: ctx,
      builder: (ctx) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            title: Text(
              dialogMap['isAdding'] ? 'Add Size'.tr() : 'Edit Size'.tr(),
            ),
            content: SingleChildScrollView(
              child: SizedBox(
                width: 150,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Form(
                      key: _formKey,
                      child: TextFormField(
                        initialValue: dialogMap['name'],
                        decoration: InputDecoration(
                          labelText: 'Name'.tr(),
                        ),
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a valid Name'.tr();
                          }
                        },
                        onSaved: (value) {
                          _sizeName = value.toString();
                        },
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

                              final hasAction = await _onSizeAction(
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
                              dialogMap['isAdding'] ? 'ADD'.tr() : 'SAVE'.tr(),
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

  static Future<bool> showVendorProductDialog(
    BuildContext ctx,
    Map<String, dynamic> dialogMap,
  ) async {
    _vendorId = dialogMap['vendorId'];
    _isLoading = false;
    final _formKey = GlobalKey<FormState>();

    final List<Map<String, dynamic>> brandsList = [];
    final List<Map<String, dynamic>> subSectionsList = [];

    dialogMap['brandsList'].forEach((brand) {
      brandsList.add({
        '_id': brand['_id'],
        'name': brand['name'],
      });
    });

    dialogMap['subsectionsList'].forEach((subSection) {
      subSectionsList.add(
        {
          '_id': subSection['_id'],
          'name': subSection['name'],
          'categoryId': subSection['category']['_id'],
          'sectionId': subSection['section']['_id']
        },
      );
    });

    final pList = [
      'True'.tr(),
      'False'.tr(),
    ];

    return await showDialog(
      barrierDismissible: false,
      context: ctx,
      builder: (ctx) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            title: Text(
              dialogMap['isAdding'] ? 'Add Product'.tr() : 'Edit Product'.tr(),
            ),
            content: SingleChildScrollView(
              child: SizedBox(
                width: 200,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            enabled: dialogMap['isAdding'],
                            initialValue: dialogMap['name'],
                            decoration: InputDecoration(
                              labelText: 'Name (English)'.tr(),
                            ),
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a valid Name'.tr();
                              }
                            },
                            onSaved: (value) {
                              _name = value.toString();
                            },
                          ),
                          TextFormField(
                            enabled: dialogMap['isAdding'],
                            initialValue: dialogMap['arabicName'],
                            decoration: InputDecoration(
                              labelText: 'Arabic Name'.tr(),
                            ),
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a valid Name'.tr();
                              }
                            },
                            onSaved: (value) {
                              _arabicName = value.toString();
                            },
                          ),
                          TextFormField(
                            enabled: dialogMap['isAdding'],
                            initialValue: dialogMap['model'],
                            decoration: InputDecoration(
                              labelText: 'Model'.tr(),
                            ),
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a valid Model'.tr();
                              }
                            },
                            onSaved: (value) {
                              _model = value.toString();
                            },
                          ),
                          TextFormField(
                            initialValue: dialogMap['price'],
                            decoration: InputDecoration(
                              border: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                color: Colors.deepOrange,
                              )),
                              labelText: 'Price'.tr(),
                            ),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a valid Price'.tr();
                              }
                            },
                            onSaved: (value) {
                              _price = value.toString();
                            },
                          ),
                          DropdownButtonFormField(
                            decoration: InputDecoration(
                              focusColor: Colors.deepOrange,
                              labelText: 'In Stock'.tr(),
                            ),
                            items: pList.map((state) {
                              return DropdownMenuItem(
                                child: Text(
                                  state,
                                ),
                                value: state,
                              );
                            }).toList(),
                            onChanged: (state) {
                              _inStock =
                                  state.toString() == pList[0] ? '1' : '0';
                            },
                            value: dialogMap['isAdding']
                                ? null
                                : dialogMap['inStock'] == '1'
                                    ? pList[0]
                                    : pList[1],
                          ),
                          if (dialogMap['isAdding'])
                            DropdownButtonFormField(
                              decoration: InputDecoration(
                                labelText: 'Has Sizes'.tr(),
                              ),
                              items: pList.map((state) {
                                return DropdownMenuItem(
                                  child: Text(
                                    state,
                                  ),
                                  value: state,
                                );
                              }).toList(),
                              onChanged: (state) {
                                _hasSizes =
                                    state.toString() == pList[0] ? '1' : '0';
                              },
                              value: dialogMap['isAdding']
                                  ? null
                                  : dialogMap['hasSizes'] == '1'
                                      ? pList[0]
                                      : pList[1],
                            ),
                          DropdownButtonFormField(
                            decoration: InputDecoration(
                              labelText: 'Choose Brand'.tr(),
                            ),
                            items: brandsList.map((brand) {
                              return DropdownMenuItem(
                                child: Text(
                                  brand['name'],
                                ),
                                value: brand,
                              );
                            }).toList(),
                            onChanged: dialogMap['isAdding']
                                ? (brand) {
                                    final bran = brand as Map<String, dynamic>;
                                    _brandId = bran['_id'];
                                  }
                                : null,
                            value: dialogMap['isAdding']
                                ? null
                                : brandsList.singleWhere(
                                    (brand) =>
                                        brand['_id'] == dialogMap['brandId'],
                                  ),
                          ),
                          DropdownButtonFormField(
                            decoration: InputDecoration(
                              labelText: 'Choose Sub-Section'.tr(),
                            ),
                            items: subSectionsList.map((subSection) {
                              return DropdownMenuItem(
                                child: Text(
                                  subSection['name'],
                                ),
                                value: subSection,
                              );
                            }).toList(),
                            onChanged: dialogMap['isAdding']
                                ? (subSection) {
                                    final sub =
                                        subSection! as Map<String, dynamic>;
                                    _subSectionId = sub['_id'];
                                    _categoryId = sub['categoryId'];
                                    _sectionId = sub['sectionId'];
                                  }
                                : null,
                            value: dialogMap['isAdding']
                                ? null
                                : subSectionsList.singleWhere(
                                    (subSection) =>
                                        subSection['_id'] ==
                                        dialogMap['subSectionId'],
                                  ),
                          ),
                          TextFormField(
                            enabled: dialogMap['isAdding'],
                            initialValue: dialogMap['description'],
                            decoration: InputDecoration(
                              labelText: 'Description'.tr(),
                            ),
                            minLines: 2,
                            maxLines: null,
                            maxLength: 2500,
                            keyboardType: TextInputType.multiline,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a valid Description'.tr();
                              } else if (value.length < 30) {
                                return 'Description must be 30 charachters long'
                                    .tr();
                              } else {
                                return null;
                              }
                            },
                            onSaved: (value) {
                              _description = value.toString();
                            },
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
                              dialogMap['isAdding'] ? 'ADD'.tr() : 'SAVE'.tr(),
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

  static Future<bool> showDecorDialog(
    BuildContext ctx,
    Map<String, dynamic> dialogMap,
  ) async {
    _isLoading = false;
    final _formKey = GlobalKey<FormState>();

    return await showDialog(
      barrierDismissible: false,
      context: ctx,
      builder: (ctx) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            title: Text(
              dialogMap['isAdding']
                  ? 'Add Decoration'.tr()
                  : 'Edit Decoration'.tr(),
            ),
            content: SingleChildScrollView(
              child: SizedBox(
                width: 200,
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        initialValue: dialogMap['color'],
                        decoration: InputDecoration(
                          labelText: 'Color'.tr(),
                        ),
                        keyboardType: TextInputType.number,
                        maxLength: 7,
                        enabled: dialogMap['isAdding'],
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a valid Color-Hex';
                          }
                          if (!RegExp(r'#[a-zA-Z0-9]{6}').hasMatch(value)) {
                            return 'Color-Hex Must be in Format #------';
                          }
                        },
                        onSaved: (value) {
                          _color = value.toString();
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 16,
                        ),
                        child: Column(
                          children: [
                            const Text(
                              'Image 1',
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            ProductImagePicker(
                              photoUrl: dialogMap['image1Url'],
                              setFileCallBack: (bytes, name, mime) {
                                _imageBytes1 = bytes;
                                _fileName1 = name;
                                _fileMime1 = mime;
                              },
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        color: Colors.deepOrange,
                        indent: 8,
                        endIndent: 8,
                        thickness: 2,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 16,
                        ),
                        child: Column(
                          children: [
                            const Text(
                              'Image 2',
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            ProductImagePicker(
                              photoUrl: dialogMap['image2Url'],
                              setFileCallBack: (bytes, name, mime) {
                                _imageBytes2 = bytes;
                                _fileName2 = name;
                                _fileMime2 = mime;
                              },
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        color: Colors.deepOrange,
                        indent: 8,
                        endIndent: 8,
                        thickness: 2,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        child: Column(
                          children: [
                            const Text(
                              'Image 3',
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            ProductImagePicker(
                              photoUrl: dialogMap['image3Url'],
                              setFileCallBack: (bytes, name, mime) {
                                _imageBytes3 = bytes;
                                _fileName3 = name;
                                _fileMime3 = mime;
                              },
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        color: Colors.deepOrange,
                        indent: 8,
                        endIndent: 8,
                        thickness: 2,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        child: Column(
                          children: [
                            const Text(
                              'Image 4',
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            ProductImagePicker(
                              photoUrl: dialogMap['image4Url'],
                              setFileCallBack: (bytes, name, mime) {
                                _imageBytes4 = bytes;
                                _fileName4 = name;
                                _fileMime4 = mime;
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
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
                              if (dialogMap['isAdding'] &&
                                  _imageBytes1 == null) {
                                showSnackBar(
                                  context: context,
                                  msg: 'Photo 1 is Required!',
                                );
                              } else {
                                loadingState(() {
                                  _isLoading = true;
                                });

                                final hasAction = await _onDecorAction(
                                  ctx,
                                  dialogMap,
                                );

                                Navigator.pop(context);
                              }
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
                            child: Text(dialogMap['isAdding'] ? 'ADD' : 'SAVE'),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('CANCEL'),
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
