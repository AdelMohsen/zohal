import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

class ProductImagePicker extends StatefulWidget {
  ProductImagePicker({
    required String photoUrl,
    required Function setFileCallBack,
    double? imageSize,
  })  : _setFileCallBack = setFileCallBack,
        _photoUrl = photoUrl,
        _imageSize = imageSize;

  final String _photoUrl;
  final double? _imageSize;
  final Function _setFileCallBack;

  @override
  _ProductImagePickerState createState() => _ProductImagePickerState();
}

class _ProductImagePickerState extends State<ProductImagePicker> {
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
        return const AssetImage('assets/images/icn_other.png');
      } else {
        return NetworkImage(widget._photoUrl);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Theme.of(context).primaryColor,
          child: Image(
            fit: BoxFit.scaleDown,
            image: _setImage(),
            height: 100,
            width: 150,
            errorBuilder: (context, error, stackTrace) => const SizedBox(
              height: 100,
              width: 150,
              child: Icon(
                Icons.web_asset,
                color: Colors.white,
                size: 84,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        TextButton.icon(
          onPressed: () => _getFileImage(context),
          icon: const Icon(Icons.image),
          label: const Text('Choose Image'),
        ),
      ],
    );
  }
}
