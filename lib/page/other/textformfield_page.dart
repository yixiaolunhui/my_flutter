import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_flutter/app/typedef/function.dart';
import 'package:my_flutter/widgets/custom_app_bar.dart';
import 'package:my_flutter/widgets/other/textformfield_clear_view.dart';

///输入框相关
class TextFormFieldPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TextFormFieldState();
  }
}

class TextFormFieldState extends State<TextFormFieldPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          title: "输入框",
          onBack: () {
            Navigator.pop(context);
          }),
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            InputTitleValue(
              title: "不能输入",
              value: "18515977366",
              enabled: false,
            ),
            InputTitleValue(
              title: "手机号",
              textInputFormatter: [
                LengthLimitingTextInputFormatter(13),
                WhitelistingTextInputFormatter(RegExp("[0-9]")),
                // MobileTextFormatter(),
              ],
            ),
            InputTitleValue(
              title: "银行卡号",
              textInputFormatter: [
                // BankCardNoTextFormatter(),
              ],
            ),
            InputTitleValue(
              title: "只能输入a-z",
              textInputFormatter: [
                WhitelistingTextInputFormatter(RegExp("[a-zA-Z]")),
              ],
            ),
            InputTitleValue(
              title: "不能输入d,a,l,o,n,g",
              textInputFormatter: [
                BlacklistingTextInputFormatter(RegExp("[dalong]"))
              ],
            ),
            InputTitleValue(
              title: "能输入a-z,但不能输入d,a,l,o,n,g",
              textInputFormatter: [
                WhitelistingTextInputFormatter(RegExp("[a-zA-Z]")),
                BlacklistingTextInputFormatter(RegExp("[dalong]"))
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// class BankCardNoTextFormatter extends TextInputFormatter {
//   TextEditingValue formatEditUpdate(
//       TextEditingValue oldValue, TextEditingValue newValue) {
//     String value = newValue.text
//         .stringSeparate(separator: ' ', count: 4, fromRightToLeft: false);
//     return new TextEditingValue(
//       text: value,
//       selection: TextSelection.collapsed(offset: value?.length ?? 0),
//     );
//   }
// }
//
// class MobileTextFormatter extends TextInputFormatter {
//   TextEditingValue formatEditUpdate(
//       TextEditingValue oldValue, TextEditingValue newValue) {
//     String value = newValue.text.mobileStringSeparate(separator: ' ');
//     return new TextEditingValue(
//       text: value,
//       selection: TextSelection.collapsed(offset: value?.length ?? 0),
//     );
//   }
// }
//
//
// //银行卡号 字符串分隔方法
// extension BankCardNoString on String {
//   String stringSeparate({
//     int count = 3,
//     String separator = ",",
//     bool fromRightToLeft = true,
//   }) {
//     try {
//       if (this.isEmpty) {
//         return "";
//       }
//       if (count < 1) {
//         return this;
//       }
//       if (count >= this.length) {
//         return this;
//       }
//       var str = this.replaceAll(separator, "");
//       var chars = str.runes.toList();
//       var namOfSeparation =
//           (chars.length.toDouble() / count.toDouble()).ceil() - 1;
//       var separatedChars = List(chars.length + namOfSeparation.round());
//       var j = 0;
//       for (var i = 0; i < chars.length; i++) {
//         separatedChars[j] = String.fromCharCode(chars[i]);
//         if (i > 0 && (i + 1) < chars.length && (i + 1) % count == 0) {
//           j += 1;
//           separatedChars[j] = separator;
//         }
//
//         j += 1;
//       }
//       return fromRightToLeft
//           ? String.fromCharCodes(separatedChars.join().runes.toList().reversed)
//           : separatedChars.join();
//     } catch (e) {}
//     return this;
//   }
// }
//
// //手机号 字符串分隔方法
// extension MobileString on String {
//   String mobileStringSeparate({
//     String separator = ",",
//   }) {
//     if (this.isEmpty) {
//       return "";
//     }
//     try {
//       var str = this.replaceAll(separator, "");
//       if (str.length > 3) {
//         String temp1 = this.substring(0, 3) + " ";
//         String temp2 = this.substring(3, this.length);
//         int count = 4;
//         var str = temp2.replaceAll(separator, "");
//         var chars = str.runes.toList();
//         var namOfSeparation =
//             (chars.length.toDouble() / count.toDouble()).ceil() - 1;
//         var separatedChars = List(chars.length + namOfSeparation.round());
//         var j = 0;
//         for (var i = 0; i < chars.length; i++) {
//           separatedChars[j] = String.fromCharCode(chars[i]);
//           if (i > 0 && (i + 1) < chars.length && (i + 1) % count == 0) {
//             j += 1;
//             separatedChars[j] = separator;
//           }
//           j += 1;
//         }
//         return temp1 + separatedChars.join();
//       }
//     } catch (e) {}
//     return this;
//   }
// }


///标题-输入框
class InputTitleValue extends StatefulWidget {
  InputTitleValue({
    Key key,
    this.title,
    this.value,
    this.hint,
    this.showDivider = true,
    this.enabled = true,
    this.callback,
    this.textInputFormatter,
  }) : super(key: key);

  String title;
  String value;
  String hint;
  bool showDivider;
  bool enabled;
  ParamSingleCallback callback;
  List<TextInputFormatter> textInputFormatter;

  @override
  State<StatefulWidget> createState() {
    return InputKeyValueState();
  }
}

class InputKeyValueState extends State<InputTitleValue> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      alignment: Alignment.centerLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Text(
                    this.widget.title ?? "",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: ClearTextFormField(
                    text: this.widget.value ?? "",
                    enabled: this.widget.enabled ?? true,
                    hintText: this.widget.hint ?? "",
                    textInputFormatter: this.widget.textInputFormatter ?? [],
                    onChanged: (value) {
                      if (this.widget.callback != null) {
                        this.widget.callback(value);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          Offstage(
            offstage: !widget.showDivider,
            child: Divider(
              height: 0.5,
              indent: 16,
              endIndent: 16,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
