import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NetworkImageWidget extends StatefulWidget {
  final String img;
  final BoxFit fit;
  const NetworkImageWidget({
    super.key,
    required this.img,
    this.fit = BoxFit.cover,
  });

  @override
  State<NetworkImageWidget> createState() => _NetworkImageWidgetState();
}

class _NetworkImageWidgetState extends State<NetworkImageWidget> {
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      key: UniqueKey(),
      width: double.infinity,
      height: double.infinity,
      progressIndicatorBuilder: (context, url, downloadProgress) => Center(
        child: CircularProgressIndicator(
            value: downloadProgress.progress, strokeWidth: 3),
      ),
      errorWidget: (context, url, error) => InkWell(
          onTap: () {
            setState(() {});
          },
          child: const Icon(Icons.refresh)),
      imageUrl: widget.img,
      fit: widget.fit,
    );
  }
}
