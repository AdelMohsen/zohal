import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ItemImagePicker extends StatefulWidget {
  ItemImagePicker({
    required bool isUser,
    required String photoUrl,
    required String language,
    required Function setFileCallBack,
    bool? hasFullWidth,
    double? imageSize,
  })  : _setFileCallBack = setFileCallBack,
        _photoUrl = photoUrl,
        _language = language,
        _isUser = isUser,
        _hasFullWidth = hasFullWidth,
        _imageSize = imageSize;

  final bool _isUser;
  final String _photoUrl;
  final String _language;
  final bool? _hasFullWidth;
  final double? _imageSize;
  final Function _setFileCallBack;

  @override
  _ItemImagePickerState createState() => _ItemImagePickerState();
}

class _ItemImagePickerState extends State<ItemImagePicker> {
  Uint8List? _imageBytes;

  void _getFileImage(BuildContext ctx) async {
    final _picker = ImagePicker();

    final photo = await _picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: widget._imageSize != null ? widget._imageSize! : null,
      maxWidth: widget._imageSize != null ? widget._imageSize! : null,
    );

    if (photo != null) {
      final fileName = photo.name;
      final mime = photo.mimeType;
      final bytes = await photo.readAsBytes();

      setState(() {
        _imageBytes = bytes;
        widget._setFileCallBack(
          bytes,
          fileName,
          mime,
        );
      });
    }
  }

  ImageProvider _setImage() {
    if (_imageBytes != null) {
      return MemoryImage(_imageBytes!);
    } else {
      if (widget._photoUrl == '') {
        return widget._isUser
            ? const AssetImage('assets/images/icn_account_circle.png')
            : const AssetImage('assets/images/icn_other.png');
      } else {
        return NetworkImage(widget._photoUrl);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        widget._isUser
            ? CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor,
                radius: 35,
                backgroundImage: _setImage(),
              )
            : Container(
                width: widget._hasFullWidth != null && widget._hasFullWidth!
                    ? double.infinity
                    : null,
                color: theme.primaryColor,
                child: Image(
                  fit: BoxFit.cover,
                  image: _setImage(),
                  height: widget._isUser ? 100 : 160,
                  width: widget._isUser ? 100 : 160,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.web_asset,
                    color: Colors.white,
                    size: 200,
                  ),
                ),
              ),
        const SizedBox(
          height: 8,
        ),
        TextButton.icon(
          onPressed: () => _getFileImage(context),
          icon: const Icon(Icons.image),
          label: Text(
            widget._language == 'EN' || widget._language == ''
                ? 'Choose Image'
                : 'اختر الصورة',
          ),
        ),
      ],
    );
  }
}
