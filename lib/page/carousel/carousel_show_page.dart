import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter/utils/image_utils.dart';
import 'package:my_flutter/widgets/custom_app_bar.dart';
import 'package:my_flutter/widgets/flutter_carousel.dart';

class CarouselShowPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CarouselShowState();
}

class CarouselShowState extends State<CarouselShowPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
          title: "旋转木马",
          onBack: () {
            Navigator.pop(context);
          }),
      body: Container(
        alignment: Alignment.center,
        child: Stack(
          children: [
            CarouselLayout(
              deviationRatio: 0.7,
              minScale: 0.5,
              childWidth: 85,
              childHeight: 85,
              isAuto: true,
              circleScale: 1,
              children: [
                Image(
                  image: ImageUtils.getAssetImage("muma2"),
                  filterQuality: FilterQuality.high,
                ),
                Image(
                  image: ImageUtils.getAssetImage("muma2"),
                  filterQuality: FilterQuality.high,
                ),
                Image(
                  image: ImageUtils.getAssetImage("muma2"),
                  filterQuality: FilterQuality.high,
                ),
                Image(
                  image: ImageUtils.getAssetImage("muma2"),
                  filterQuality: FilterQuality.high,
                ),
                Image(
                  image: ImageUtils.getAssetImage("muma2"),
                  filterQuality: FilterQuality.high,
                ),
                Image(
                  image: ImageUtils.getAssetImage("muma2"),
                  filterQuality: FilterQuality.high,
                ),
                Image(
                  image: ImageUtils.getAssetImage("muma2"),
                  filterQuality: FilterQuality.high,
                ),
                Image(
                  image: ImageUtils.getAssetImage("muma2"),
                  filterQuality: FilterQuality.high,
                ),
                Image(
                  image: ImageUtils.getAssetImage("muma2"),
                  filterQuality: FilterQuality.high,
                ),
                Image(
                  image: ImageUtils.getAssetImage("muma2"),
                  filterQuality: FilterQuality.high,
                ),
                Image(
                  image: ImageUtils.getAssetImage("muma2"),
                  filterQuality: FilterQuality.high,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
