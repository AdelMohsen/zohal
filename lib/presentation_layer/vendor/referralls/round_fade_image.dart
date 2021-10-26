import 'package:flutter/material.dart';

class RoundedFadeImage extends StatelessWidget {
  const RoundedFadeImage({
    required String photoUrl,
    required double radius,
    bool isUser = true,
  })  : _photoUrl = photoUrl,
        _radius = radius,
        _isUser = isUser;

  final String _photoUrl;
  final double _radius;
  final bool _isUser;

  @override
  Widget build(BuildContext context) {
    return _isUser
        ? _photoUrl.isEmpty
            ? CircleAvatar(
                child: Icon(
                  Icons.account_circle,
                  size: _radius + 15,
                ),
                radius: _radius,
              )
            : Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(_radius + 15),
                  child: Stack(
                    children: [
                      Container(
                        width: _radius + 15,
                        height: _radius + 15,
                        color: Theme.of(context).primaryColor,
                      ),
                      FadeInImage(
                        width: _radius + 15,
                        height: _radius + 15,
                        placeholder: AssetImage(
                          'assets/images/loading.gif',
                        ),
                        image: NetworkImage(
                          _photoUrl,
                        ),
                        imageErrorBuilder: (context, error, stackTrace) =>
                            Image.asset(
                          'assets/images/icn_account_circle.png',
                          width: _radius + 15,
                          height: _radius + 15,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),
              )
        : ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: _radius + 15,
              minHeight: _radius + 15,
              maxWidth: _radius + 15,
              maxHeight: _radius + 15,
            ),
            child: Stack(
              children: [
                Container(
                  width: _radius + 15,
                  height: _radius + 15,
                  color: Theme.of(context).primaryColor,
                ),
                _photoUrl.isEmpty
                    ? Center(
                        child: Image.asset(
                          'assets/images/icn_other.png',
                          fit: BoxFit.cover,
                        ),
                      )
                    : Center(
                        child: FadeInImage(
                          width: _radius + 15,
                          height: _radius + 15,
                          placeholder: AssetImage(
                            'assets/images/loading.gif',
                          ),
                          image: NetworkImage(
                            _photoUrl,
                          ),
                          imageErrorBuilder: (context, error, stackTrace) =>
                              Image.asset(
                            'assets/images/icn_other.png',
                            width: _radius + 15,
                            height: _radius + 15,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
              ],
            ),
          );
  }
}
