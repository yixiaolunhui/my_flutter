import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter/utils/image_utils.dart';
import 'package:my_flutter/widgets/custom_app_bar.dart';
import 'package:my_flutter/widgets/flutter_carousel.dart';

class CarouselPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CarouselState();
}

class CarouselState extends State<CarouselPage> {
  double value = 0.3;
  double scale = 0.5;
  bool isAuto = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CustomAppBar(
          title: "旋转木马",
          onBack: () {
            Navigator.pop(context);
          }),
      body: Container(
        child: Stack(
          children: [
            CarouselLayout(
              deviationRatio: this.value,
              minScale: this.scale,
              childWidth: 80,
              childHeight: 80,
              isAuto: isAuto,
              children: [
                Image(
                  image: ImageUtils.getAssetImage("boy"),
                  filterQuality: FilterQuality.high,
                ),
                Image(
                  image: ImageUtils.getAssetImage("caishen"),
                  filterQuality: FilterQuality.high,
                ),
                Image(
                  image: ImageUtils.getAssetImage("damo"),
                  filterQuality: FilterQuality.high,
                ),
                Image(
                  image: ImageUtils.getAssetImage("girl"),
                  filterQuality: FilterQuality.high,
                ),
                Image(
                  image: ImageUtils.getAssetImage("hongbao"),
                  filterQuality: FilterQuality.high,
                ),
                Image(
                  image: ImageUtils.getAssetImage("laotou"),
                  filterQuality: FilterQuality.high,
                ),
                Image(
                  image: ImageUtils.getAssetImage("linghongbao"),
                  filterQuality: FilterQuality.high,
                ),
                Image(
                  image: ImageUtils.getAssetImage("mengnan"),
                  filterQuality: FilterQuality.high,
                ),
                Image(
                  image: ImageUtils.getAssetImage("yang"),
                  filterQuality: FilterQuality.high,
                ),
                Image(
                  image: ImageUtils.getAssetImage("yangmao"),
                  filterQuality: FilterQuality.high,
                ),
                Image(
                  image: ImageUtils.getAssetImage("zhaocaimao"),
                  filterQuality: FilterQuality.high,
                ),
              ],
            ),
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(" Y轴旋转："),
                        Expanded(
                          child: Slider(
                            value: this.value,
                            onChanged: (result) {
                              this.value = result;
                              if (mounted) {
                                setState(() {});
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(" 缩放比例："),
                        Expanded(
                          child: Slider(
                            value: this.scale,
                            onChanged: (result) {
                              this.scale = result;
                              if (mounted) {
                                setState(() {});
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(" 自动旋转："),
                        Switch(
                          value: isAuto,
                          onChanged: (value) {
                            this.isAuto = value;
                            if (mounted) {
                              setState(() {});
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
