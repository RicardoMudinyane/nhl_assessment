import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../models/const_data.dart';


/// This is a CachedNetworkImage widget to it where ever we are using network images

class ImageWidget extends StatelessWidget {
  final String imageUrl;
  final double imageSize;
  const ImageWidget({
    Key? key,
    required this.imageUrl,
    required this.imageSize
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
        imageUrl: imageUrl,
        imageBuilder: (context, imageProvider) => Container(
          width: imageSize,
          height: imageSize,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.contain,
            ),
          ),
        ),
        placeholder: (context, url){
          return placeHolder(ConstData().placeHolderImage);
        },
        errorWidget: (context, url, error){
          return placeHolder(ConstData().nhlLogo);
        }
    );
  }
  Widget placeHolder(String placeHolder) => Container(
    width: imageSize,
    height: imageSize,
    decoration: BoxDecoration(
      image: DecorationImage(
        image: NetworkImage(placeHolder),
        fit: BoxFit.contain,
      ),
    ),
  );
}