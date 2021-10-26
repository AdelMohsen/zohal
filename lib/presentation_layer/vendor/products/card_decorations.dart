import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class DecorationsCard extends StatefulWidget {
  DecorationsCard({
    required String image1Url,
    required String image2Url,
    required String image3Url,
    required String image4Url,
    required bool image2NullCheck,
    required bool image3NullCheck,
    required bool image4NullCheck,
    required String color,
    required String imageCount,
    required Function editCallback,
    required Function deleteCallback,
  })  : _image1Url = image1Url,
        _image2Url = image2Url,
        _image3Url = image3Url,
        _image4Url = image4Url,
        _image2NullCheck = image2NullCheck,
        _image3NullCheck = image3NullCheck,
        _image4NullCheck = image4NullCheck,
        _color = color,
        _imageCount = imageCount,
        _editCallback = editCallback,
        _deleteCallback = deleteCallback;

  final String _image1Url;
  final String _image2Url;
  final String _image3Url;
  final String _image4Url;
  final bool _image2NullCheck;
  final bool _image3NullCheck;
  final bool _image4NullCheck;
  final String _color;
  final String _imageCount;
  final Function _editCallback;
  final Function _deleteCallback;

  @override
  State<DecorationsCard> createState() => _DecorationsCardState();
}

class _DecorationsCardState extends State<DecorationsCard> {
  var _selectedImage = 1;
  late Function _mainImageState;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(4),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 3,
                fit: FlexFit.tight,
                child: Card(
                  elevation: 4,
                  margin: const EdgeInsets.all(0),
                  child: StatefulBuilder(builder: (context, mainImageState) {
                    _mainImageState = mainImageState;
                    return FadeInImage.assetNetwork(
                      placeholder: 'assets/images/loading.gif',
                      image: _selectedImage == 1
                          ? widget._image1Url
                          : _selectedImage == 2
                              ? widget._image2Url
                              : _selectedImage == 3
                                  ? widget._image3Url
                                  : widget._image4Url,
                      imageScale: 3,
                      width: double.infinity,
                      height: 150,
                      fit: BoxFit.scaleDown,
                      imageErrorBuilder: (context, error, stackTrace) =>
                          Container(
                        color: Colors.red,
                        child: const Icon(
                          Icons.web_asset_off_outlined,
                          size: 24,
                          color: Colors.white,
                        ),
                      ),
                    );
                  }),
                ),
              ),
              Flexible(
                flex: 4,
                fit: FlexFit.tight,
                child: Padding(
                  padding: const EdgeInsets.all(
                    8,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () => widget._editCallback(),
                            icon: const Icon(Icons.edit),
                            color: Colors.grey,
                          ),
                          IconButton(
                            onPressed: () => widget._deleteCallback(),
                            icon: const Icon(Icons.delete),
                            color: Colors.redAccent,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Color:'.tr(),
                            style:
                                Theme.of(context).textTheme.subtitle1?.copyWith(
                                      color: Colors.deepOrange,
                                    ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Card(
                            elevation: 4,
                            child: CircleAvatar(
                                radius: 8,
                                backgroundColor: HexColor(
                                  widget._color,
                                )),
                            borderOnForeground: true,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            widget._color.toLowerCase(),
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Images Count:'.tr(),
                            style:
                                Theme.of(context).textTheme.subtitle1?.copyWith(
                                      color: Colors.deepOrange,
                                    ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            widget._imageCount,
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      //   if (ResponsiveWidget.isLargeScreen(context) ||
                      //       ResponsiveWidget.isMediumScreen(context))
                      //     StatefulBuilder(builder: (context, cardsState) {
                      //       return Row(
                      //         children: [
                      //           Card(
                      //             elevation: _selectedImage == 1 ? 5 : 2,
                      //             shadowColor: _selectedImage == 1
                      //                 ? Get.theme.primaryColor
                      //                 : null,
                      //             margin: const EdgeInsets.all(0),
                      //             child: InkWell(
                      //               onTap: _selectedImage == 1
                      //                   ? null
                      //                   : () {
                      //                       cardsState(() {
                      //                         _selectedImage = 1;
                      //                       });
                      //                       _mainImageState(() {});
                      //                     },
                      //               child: Image.network(
                      //                 widget._image1Url,
                      //                 width: 72,
                      //                 height: 72,
                      //                 scale: 10,
                      //                 fit: BoxFit.scaleDown,
                      //               ),
                      //             ),
                      //           ),
                      //           const SizedBox(
                      //             width: 8,
                      //           ),
                      //           Card(
                      //             elevation: _selectedImage == 2 ? 5 : 2,
                      //             margin: const EdgeInsets.all(0),
                      //             shadowColor: _selectedImage == 2
                      //                 ? Get.theme.primaryColor
                      //                 : null,
                      //             child: InkWell(
                      //               onTap: widget._image2NullCheck
                      //                   ? _selectedImage == 2
                      //                       ? null
                      //                       : () {
                      //                           cardsState(() {
                      //                             _selectedImage = 2;
                      //                           });
                      //                           _mainImageState(() {});
                      //                         }
                      //                   : null,
                      //               child: widget._image2NullCheck
                      //                   ? FadeInImage.assetNetwork(
                      //                       width: 72,
                      //                       height: 72,
                      //                       placeholder:
                      //                           'assets/images/loading.gif',
                      //                       image: widget._image2Url,
                      //                       imageScale: 10,
                      //                       fit: BoxFit.scaleDown,
                      //                     )
                      //                   : Container(
                      //                       color: Get.theme.primaryColor,
                      //                       child: Image.asset(
                      //                         'assets/images/icn_other.png',
                      //                         width: 72,
                      //                         height: 72,
                      //                         fit: BoxFit.scaleDown,
                      //                       ),
                      //                     ),
                      //             ),
                      //           ),
                      //           const SizedBox(
                      //             width: 8,
                      //           ),
                      //           Card(
                      //             elevation: _selectedImage == 3 ? 5 : 2,
                      //             shadowColor: _selectedImage == 3
                      //                 ? Get.theme.primaryColor
                      //                 : null,
                      //             margin: const EdgeInsets.all(0),
                      //             child: InkWell(
                      //               onTap: widget._image3NullCheck
                      //                   ? _selectedImage == 3
                      //                       ? null
                      //                       : () {
                      //                           cardsState(() {
                      //                             _selectedImage = 3;
                      //                           });
                      //                           _mainImageState(() {});
                      //                         }
                      //                   : null,
                      //               child: widget._image3NullCheck
                      //                   ? FadeInImage.assetNetwork(
                      //                       width: 72,
                      //                       height: 72,
                      //                       placeholder:
                      //                           'assets/images/loading.gif',
                      //                       image: widget._image3Url,
                      //                       imageScale: 10,
                      //                       fit: BoxFit.scaleDown,
                      //                     )
                      //                   : Container(
                      //                       color: Get.theme.primaryColor,
                      //                       child: Image.asset(
                      //                         'assets/images/icn_other.png',
                      //                         width: 72,
                      //                         height: 72,
                      //                         fit: BoxFit.scaleDown,
                      //                       ),
                      //                     ),
                      //             ),
                      //           ),
                      //           const SizedBox(
                      //             width: 8,
                      //           ),
                      //           Card(
                      //             elevation: _selectedImage == 4 ? 5 : 2,
                      //             shadowColor: _selectedImage == 4
                      //                 ? Get.theme.primaryColor
                      //                 : null,
                      //             margin: const EdgeInsets.all(0),
                      //             child: InkWell(
                      //               onTap: widget._image4NullCheck
                      //                   ? _selectedImage == 4
                      //                       ? null
                      //                       : () {
                      //                           cardsState(() {
                      //                             _selectedImage = 4;
                      //                           });
                      //                           _mainImageState(() {});
                      //                         }
                      //                   : null,
                      //               child: widget._image4NullCheck
                      //                   ? FadeInImage.assetNetwork(
                      //                       width: 72,
                      //                       height: 72,
                      //                       placeholder:
                      //                           'assets/images/loading.gif',
                      //                       image: widget._image4Url,
                      //                       imageScale: 10,
                      //                       imageErrorBuilder:
                      //                           (context, error, stackTrace) =>
                      //                               Container(
                      //                         color: Colors.red,
                      //                         child: Icon(
                      //                           Icons.web_asset_off_outlined,
                      //                           size: 72,
                      //                           color: Colors.white,
                      //                         ),
                      //                       ),
                      //                       fit: BoxFit.scaleDown,
                      //                     )
                      //                   : Container(
                      //                       color: Get.theme.primaryColor,
                      //                       child: Image.asset(
                      //                         'assets/images/icn_other.png',
                      //                         width: 72,
                      //                         height: 72,
                      //                         fit: BoxFit.scaleDown,
                      //                       ),
                      //                     ),
                      //             ),
                      //           ),
                      //         ],
                      //       );
                      //     })
                      //
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 32,
            ),
            child: StatefulBuilder(builder: (context, cardsState) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    elevation: _selectedImage == 1 ? 5 : 2,
                    shadowColor: _selectedImage == 1 ? Colors.deepOrange : null,
                    margin: const EdgeInsets.all(0),
                    child: InkWell(
                      onTap: _selectedImage == 1
                          ? null
                          : () {
                              cardsState(() {
                                _selectedImage = 1;
                              });
                              _mainImageState(() {});
                            },
                      child: Image.network(
                        widget._image1Url,
                        width: 72,
                        height: 72,
                        scale: 10,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Card(
                    elevation: _selectedImage == 2 ? 5 : 2,
                    margin: const EdgeInsets.all(0),
                    shadowColor: _selectedImage == 2 ? Colors.deepOrange : null,
                    child: InkWell(
                      onTap: widget._image2NullCheck
                          ? _selectedImage == 2
                              ? null
                              : () {
                                  cardsState(() {
                                    _selectedImage = 2;
                                  });
                                  _mainImageState(() {});
                                }
                          : null,
                      child: widget._image2NullCheck
                          ? FadeInImage.assetNetwork(
                              width: 72,
                              height: 72,
                              placeholder: 'assets/images/loading.gif',
                              image: widget._image2Url,
                              imageScale: 10,
                              fit: BoxFit.scaleDown,
                            )
                          : Container(
                              color: Colors.deepOrange,
                              child: Image.asset(
                                'assets/images/icn_other.png',
                                width: 72,
                                height: 72,
                                fit: BoxFit.scaleDown,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Card(
                    elevation: _selectedImage == 3 ? 5 : 2,
                    shadowColor: _selectedImage == 3 ? Colors.deepOrange : null,
                    margin: const EdgeInsets.all(0),
                    child: InkWell(
                      onTap: widget._image3NullCheck
                          ? _selectedImage == 3
                              ? null
                              : () {
                                  cardsState(() {
                                    _selectedImage = 3;
                                  });
                                  _mainImageState(() {});
                                }
                          : null,
                      child: widget._image3NullCheck
                          ? FadeInImage.assetNetwork(
                              width: 72,
                              height: 72,
                              placeholder: 'assets/images/loading.gif',
                              image: widget._image3Url,
                              imageScale: 10,
                              fit: BoxFit.scaleDown,
                            )
                          : Container(
                              color: Colors.deepOrange,
                              child: Image.asset(
                                'assets/images/icn_other.png',
                                width: 72,
                                height: 72,
                                fit: BoxFit.scaleDown,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Card(
                    elevation: _selectedImage == 4 ? 5 : 2,
                    shadowColor: _selectedImage == 4 ? Colors.deepOrange : null,
                    margin: const EdgeInsets.all(0),
                    child: InkWell(
                      onTap: widget._image4NullCheck
                          ? _selectedImage == 4
                              ? null
                              : () {
                                  cardsState(() {
                                    _selectedImage = 4;
                                  });
                                  _mainImageState(() {});
                                }
                          : null,
                      child: widget._image4NullCheck
                          ? FadeInImage.assetNetwork(
                              width: 72,
                              height: 72,
                              placeholder: 'assets/images/loading.gif',
                              image: widget._image4Url,
                              imageScale: 10,
                              imageErrorBuilder: (context, error, stackTrace) =>
                                  Container(
                                color: Colors.red,
                                child: Icon(
                                  Icons.web_asset_off_outlined,
                                  size: 72,
                                  color: Colors.white,
                                ),
                              ),
                              fit: BoxFit.scaleDown,
                            )
                          : Container(
                              color: Colors.deepOrange,
                              child: Image.asset(
                                'assets/images/icn_other.png',
                                width: 72,
                                height: 72,
                                fit: BoxFit.scaleDown,
                              ),
                            ),
                    ),
                  ),
                ],
              );
            }),
          )
        ],
      ),
    );
  }
}
