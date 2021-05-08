import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;

///自定义尺子
class RulerView extends StatefulWidget {

  //默认值
  final int value;
  //最小值
  final int minValue;
  //最大值
  final int maxValue;
  //步数 一个刻度的值
  final int step;
  //尺子的宽度
  final int width;
  //尺子的高度
  final int height;
  //大刻度的总数
  int perScaleCount;
  //每个大刻度的子刻度数
  final int subScaleCountPerScale;
  //大格的宽度
  int gridWidth;
  //每一刻度的宽度
  final int subScaleWidth;

  int listViewItemCount;

  double paddingItemWidth;

  final void Function(int) onSelectedChanged;

  ///返回标尺刻度所展示的数值字符串
  String Function(int) scaleTransformer;

  ///刻度颜色
  final Color scaleColor;

  ///指示器颜色
  final Color indicatorColor;

  ///刻度文字颜色
  final Color scaleTextColor;

  RulerView({
    Key key,
    this.value = 500,
    this.minValue = 100,
    this.maxValue = 900,
    this.step = 1,
    this.width = 200,
    this.height = 60,
    this.subScaleCountPerScale = 10,
    this.subScaleWidth = 8,
    @required this.onSelectedChanged,
    this.scaleTransformer,
    this.scaleColor = const Color(0xFFE9E9E9),
    this.indicatorColor = const Color(0xFF3995FF),
    this.scaleTextColor = const Color(0xFF8E99A0),
  }) : super(key: key) {

    //每个大刻度的子刻度数必须是偶数
    if (subScaleCountPerScale % 2 != 0) {
      throw Exception("subScaleCountPerScale必须是偶数");
    }

    //检查最大数-最小数必须是步数的倍数
    if ((maxValue - minValue) % step != 0) {
      throw Exception("(maxValue - minValue)必须是step的整数倍");
    }

    //计算总刻度数
    int totalSubScaleCount = (maxValue - minValue) ~/ step;

    //检查总刻度数必须是大刻度的倍数
    if (totalSubScaleCount % subScaleCountPerScale != 0) {
      throw Exception("(maxValue - minValue)~/step必须是subScaleCountPerScale的整数倍");
    }


    //第一个grid和最后一个grid都只会展示一半数量的subGrid，因此perScaleCount需要+1
    perScaleCount = totalSubScaleCount ~/ subScaleCountPerScale + 1;

    gridWidth = subScaleWidth * subScaleCountPerScale;

    //每个grid都是listView的一个item
    //除此之外，在第一个grid之前和最后一个grid之后，还需要各填充一个空白item，
    //这样第一个item和最后一个item才能滚动到屏幕中间。
    listViewItemCount = perScaleCount + 2;

    //空白item的宽度
    paddingItemWidth = width / 2 - gridWidth / 2;

    if (scaleTransformer == null) {
      scaleTransformer = (value) {
        return value.toString();
      };
    }
  }

  @override
  State<StatefulWidget> createState() {
    return RulerState();
  }
}

class RulerState extends State<RulerView> {
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController(
      //计算初始偏移量
      initialScrollOffset: (widget.value - widget.minValue) /
          widget.step * widget.subScaleWidth,
    );
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width.toDouble(),
      height: widget.height.toDouble(),
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          NotificationListener(
            onNotification: _onNotification,
            child: ListView.builder(
              physics: ClampingScrollPhysics(),
              padding: EdgeInsets.all(0),
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: widget.listViewItemCount,
              itemBuilder: (BuildContext context, int index) {
                //首尾空白元素
                if (index == 0 || index == widget.listViewItemCount - 1) {
                  return Container(
                    width: widget.paddingItemWidth,
                    height: 0,
                  );
                  //普通元素
                } else {
                  int type;
                  //第一个普通元素
                  if (index == 1) {
                    type = 0;
                    //最后一个普通元素
                  } else if (index == widget.listViewItemCount - 2) {
                    type = 2;
                    //中间普通元素
                  } else {
                    type = 1;
                  }

                  return Container(
                    child: NumberPickerItem(
                      subGridCount: widget.subScaleCountPerScale,
                      subScaleWidth: widget.subScaleWidth,
                      itemHeight: widget.height,
                      valueStr: widget.scaleTransformer(widget.minValue +
                          (index - 1) *
                              widget.subScaleCountPerScale *
                              widget.step),
                      type: type,
                      scaleColor: widget.scaleColor,
                      scaleTextColor: widget.scaleTextColor,
                    ),
                  );
                }
              },
            ),
          ),
          //指示器
          Container(
            width: 2,
            height: widget.height / 2,
            color: widget.indicatorColor,
          ),
        ],
      ),
    );
  }

  ///监听滚动通知
  bool _onNotification(Notification notification) {
    if (notification is ScrollNotification) {
      //距离widget中间最近的刻度值
      int centerValue =
          (notification.metrics.pixels / widget.subScaleWidth).round() *
              widget.step +
              widget.minValue;

      // 通知回调选中值改变了
      if(widget.onSelectedChanged!=null){
        widget.onSelectedChanged(centerValue);
      }
      //若用户手指离开屏幕且列表的滚动停止，则滚动到centerValue
      if (_scrollingStopped(notification, _scrollController)) {
        select(centerValue);
      }
    }

    return true; //停止通知冒泡
  }

  ///判断是否用户手指离开屏幕且列表的滚动停止
  bool _scrollingStopped(
      Notification notification,
      ScrollController scrollController,
      ) {
    return notification is UserScrollNotification &&
        notification.direction == ScrollDirection.idle &&
        scrollController.position.activity is! HoldScrollActivity;
  }


  ///选中值
  select(int valueToSelect) {
    _scrollController.animateTo(
      (valueToSelect - widget.minValue) / widget.step * widget.subScaleWidth,
      duration: Duration(milliseconds: 200),
      curve: Curves.decelerate,
    );
  }
}


///每个item中间为长刻度，并在下方显示数值。两边都是短刻度
class NumberPickerItem extends StatelessWidget {
  final int subGridCount;
  final int subScaleWidth;
  final int itemHeight;
  final String valueStr;

  //0:列表首item 1:中间item 2:尾item
  final int type;

  final Color scaleColor;
  final Color scaleTextColor;

  const NumberPickerItem({
    Key key,
    @required this.subGridCount,
    @required this.subScaleWidth,
    @required this.itemHeight,
    @required this.valueStr,
    @required this.type,
    @required this.scaleColor,
    @required this.scaleTextColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double itemWidth = (subScaleWidth * subGridCount).toDouble();
    double itemHeight = this.itemHeight.toDouble();

    return CustomPaint(
      size: Size(itemWidth, itemHeight),
      painter: MyPainter(this.subScaleWidth, this.valueStr, this.type,
          this.scaleColor, this.scaleTextColor),
    );
  }
}

class MyPainter extends CustomPainter {
  final int subScaleWidth;

  final String valueStr;

  //0:列表首item 1:中间item 2:尾item
  final int type;

  final Color scaleColor;

  final Color scaleTextColor;

  Paint _linePaint;

  double _lineWidth = 2;

  MyPainter(this.subScaleWidth, this.valueStr, this.type, this.scaleColor,
      this.scaleTextColor) {
    _linePaint = Paint()
      ..isAntiAlias = true
      ..style = PaintingStyle.stroke
      ..strokeWidth = _lineWidth
      ..color = scaleColor;
  }

  @override
  void paint(Canvas canvas, Size size) {
    drawLine(canvas, size);
    drawText(canvas, size);
  }

  void drawLine(Canvas canvas, Size size) {
    double startX, endX;
    switch (type) {
      case 0: //首元素只绘制右半部分
        startX = size.width / 2;
        endX = size.width;
        break;
      case 2: //尾元素只绘制左半部分
        startX = 0;
        endX = size.width / 2;
        break;
      default: //中间元素全部绘制
        startX = 0;
        endX = size.width;
    }

    //绘制横线
    canvas.drawLine(Offset(startX, 0 + _lineWidth / 2),
        Offset(endX, 0 + _lineWidth / 2), _linePaint);

    //绘制竖线
    for (double x = startX; x <= endX; x += subScaleWidth) {
      if (x == size.width / 2) {
        //中间为长刻度
        canvas.drawLine(
            Offset(x, 0), Offset(x, size.height * 3 / 8), _linePaint);
      } else {
        //其他为短刻度
        canvas.drawLine(Offset(x, 0), Offset(x, size.height / 4), _linePaint);
      }
    }
  }

  void drawText(Canvas canvas, Size size) {
    //文字水平方向居中对齐，竖直方向底对齐
    ui.Paragraph p = _buildText(valueStr, size.width);
    //获得文字的宽高
    double halfWidth = p.minIntrinsicWidth / 2;
    double halfHeight = p.height / 2;
    canvas.drawParagraph(
        p, Offset(size.width / 2 - halfWidth, size.height - p.height));
  }

  ui.Paragraph _buildText(String content, double maxWidth) {
    ui.ParagraphBuilder paragraphBuilder =
    ui.ParagraphBuilder(ui.ParagraphStyle());
    paragraphBuilder.pushStyle(
      ui.TextStyle(
        fontSize: 14,
        color: this.scaleTextColor,
      ),
    );
    paragraphBuilder.addText(content);

    ui.Paragraph paragraph = paragraphBuilder.build();
    paragraph.layout(ui.ParagraphConstraints(width: maxWidth));

    return paragraph;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
