import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_perpus/helper/color_palette.dart';
import 'package:my_perpus/model/buku_model.dart';

class BookContainer extends StatelessWidget {
  const BookContainer(
      {Key? key,
      this.imageHeight = 200,
      this.onTapBook,
      required this.bukuModel})
      : super(key: key);
  final double imageHeight;
  final BukuModel bukuModel;
  final Function()? onTapBook;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapBook,
      child: Container(
        width: 150,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: bukuModel.gambar!,
              imageBuilder: (context, imageProvider) => Container(
                height: imageHeight,
                width: 150,
                foregroundDecoration: bukuModel.stok>0
                    ? BoxDecoration()
                    : BoxDecoration(
                  color: ColorPalette.generalSoftGrey,
                  backgroundBlendMode: BlendMode.saturation,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                      image: imageProvider, fit: BoxFit.cover),
                ),
              ),
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            SizedBox(height: 10),
            Text(
              bukuModel.judul,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 4),
            Expanded(
              child: Text(
                bukuModel.pengarang,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
