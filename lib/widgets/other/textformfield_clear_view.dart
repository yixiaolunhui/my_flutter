import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

///带有清空按钮的输入框
class ClearTextFormField extends StatefulWidget {
  ClearTextFormField({
    Key key,
    this.hintStyle,
    this.textStyle,
    this.keyboardType,
    this.enabled,
    this.text,
    this.hintText,
    this.onChanged,
    this.textInputFormatter,
  }) : super(key: key);

  //hint样式
  TextStyle hintStyle;

  //text样式
  TextStyle textStyle;

  //输入类型
  TextInputType keyboardType;

  //默认值
  String text;

  //hint值
  String hintText;

  //是否可以输入
  bool enabled = true;

  //输入回调
  TextFormFieldChangeCallback onChanged;

  //输入限制集合
  List<TextInputFormatter> textInputFormatter;

  @override
  State<StatefulWidget> createState() {
    return ClearTextFormFieldState();
  }
}

class ClearTextFormFieldState extends State<ClearTextFormField> {
  TextEditingController _controller;

  //是否显示删除按钮
  bool _isShowClear = false;

  @override
  void initState() {
    super.initState();
    //创建TextEditingController
    _controller = TextEditingController.fromValue(
      TextEditingValue(
        text: this.widget.text ?? "",
        selection: TextSelection.fromPosition(
          TextPosition(
              affinity: TextAffinity.downstream,
              offset: this.widget.text?.length ?? 0),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextFormField(
              controller: _controller,
              enabled: this.widget.enabled,
              style: this.widget.textStyle,
              keyboardType: this.widget.keyboardType,
              keyboardAppearance: Brightness.light,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: this.widget.hintText,
                hintStyle: this.widget.hintStyle,
              ),
              inputFormatters: this.widget.textInputFormatter,
              onChanged: (value) {
                _isShowClear = !isEmpty(value);
                _controller.selection = TextSelection.fromPosition(
                  TextPosition(
                      offset: value?.length ?? 0,
                      affinity: TextAffinity.downstream),
                );
                if (this.widget.onChanged != null) {
                  this.widget.onChanged(value);
                }
                this.widget.text = value ?? "";
                setState(() {});
              },
            ),
          ),
          Offstage(
            offstage: !_isShowClear,
            child: GestureDetector(
              onTap: () {
                _controller?.clear();
                if (this.widget.onChanged != null) {
                  this.widget.onChanged("");
                }
                _isShowClear = false;
                setState(() {});
              },
              child: Icon(
                Icons.cancel,
                size: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

///接口回调
typedef TextFormFieldChangeCallback<D> = dynamic Function(D data);

///字符串是否为空
bool isEmpty(String str) {
  if (str == null || str.isEmpty) {
    return true;
  }
  return false;
}
