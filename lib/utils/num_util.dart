// ignore_for_file: constant_identifier_names
import 'package:flutter/services.dart';

class NumUtil {

  /// 保留固定小数位数
  /// The parameter [fractionDigits] must be an integer satisfying: `0 <= fractionDigits <= 20`.
  static num? getNumByValueStr(String valueStr, {int? fractionDigits}) {
    double? value = double.tryParse(valueStr);
    return fractionDigits == null
        ? value
        : getNumByValueDouble(value, fractionDigits);
  }

  static num? getNumByValueDouble(double? value, int fractionDigits) {
    if (value == null) return null;
    String valueStr = value.toStringAsFixed(fractionDigits);
    return fractionDigits == 0
        ? int.tryParse(valueStr)
        : double.tryParse(valueStr);
  }

  static String formatNum(double? value, int fractionDigits, {bool separateThousands = false}) {
    if (value == null) return "0.00";
    var text = value.toStringAsFixed(fractionDigits);
    if (separateThousands) {
      text = _separateThousands(text) ?? text;
    }
    return text;
  }

  /// 数量格式化
  static String formatQuantity(int? quantity, {String lang = "en_US"}) {
    if (quantity == null) return "";
    switch (lang) {
      case "zh_CN":
        if (quantity < 1000000) {
          return quantity.toString();
        } else if (quantity >= 1000000 && quantity < 100000000) {
          return NumUtil.formatNum(quantity / 10000, 2) + "万";
        } else if (quantity >= 100000000 && quantity < 1000000000000) {
          return NumUtil.formatNum(quantity / 100000000, 2) + "亿";
        } else {
          return NumUtil.formatNum(quantity / 1000000000000, 2) + "万亿";
        }
      case "zh_HK":
        if (quantity < 1000000) {
          return quantity.toString();
        } else if (quantity >= 1000000 && quantity < 100000000) {
          return NumUtil.formatNum(quantity / 10000, 2) + "萬";
        } else if (quantity >= 100000000 && quantity < 1000000000000) {
          return NumUtil.formatNum(quantity / 100000000, 2) + "億";
        } else {
          return NumUtil.formatNum(quantity / 1000000000000, 2) + "萬億";
        }
      default:
        if (quantity < 1000) {
          return quantity.toString();
        } else if (quantity >= 1000 && quantity < 1000000) {
          return NumUtil.formatNum(quantity / 1000, 2) + "K";
        } else if (quantity >= 1000000 && quantity < 1000000000) {
          return NumUtil.formatNum(quantity / 1000000, 2) + "M";
        } else if (quantity >= 1000000000 && quantity < 1000000000000) {
          return NumUtil.formatNum(quantity / 1000000000, 2) + "B";
        } else {
          return NumUtil.formatNum(quantity / 1000000000000, 2) + "T";
        }
    }
  }

  /// 插入千分位符号
  static String? _separateThousands(String? text) {
    if (text == null || text.isEmpty) return text;
    return text.replaceAllMapped(RegExp(r"(\d)(?=(?:\d{3})+\b)"), (match)=>"${match.group(1)},");
  }
}

/// 自动添加分割符
class AutoSeperateTextInputFormatter extends TextInputFormatter {
  AutoSeperateTextInputFormatter({this.isCnPhone = true, this.isCnIdCard = false,
    this.seperateNum, this.maxLength});

  static RegExp regExp = RegExp(r"\s+\b|\b\s");

  final bool isCnPhone;// 是否是大陆手机号（采用3-4-4的分割方法,长度限制11位）
  final bool isCnIdCard;// 是否是大陆身份证 （采用6-4-4-4，长度限制18位）

  final int? seperateNum;// 固定的分割长度（如4位分割）
  final int? maxLength;// 最大长度

  int getSeperateNum() => seperateNum ?? 4;

  /// 获取格式化后的文本数据
  static String getFormatText(String? text) {
    if (text == null) return "";
    return text.replaceAll(regExp, "");
  }

  /// 分割大陆身份证号码
  static String seperateIdCardNumber(String? idCardNumber) {
    if (idCardNumber == null) return "";
    String text = idCardNumber.replaceAll(regExp, "");
    String string = "";
    for (int i = 0; i < text.length; i++) {
      if (i > 17) {
        break;
      }
      if (i == 6 || i == 10 || i == 14) {
        if (text[i] != " ") {
          string = string + " ";
        }
      }
      string = string + text[i];
    }
    return string;
  }

  /// 分割大陆号码
  static String seperateCnPhone(String? phone) {
    if (phone == null) return "";
    String text = phone.replaceAll(regExp, "");
    String string = "";
    for (int i = 0; i < text.length; i++) {
      if (i > 10) {
        break;
      }
      if (i == 3 || i == 7) {
        if (text[i] != " ") {
          string = string + " ";
        }
      }
      string = string + text[i];
    }
    return string;
  }

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String text = newValue.text;
    String positionStr = (text.substring(0, newValue.selection.baseOffset))
        .replaceAll(regExp, "");//获取光标左边的文本
    //计算格式化后的光标位置
    int position;
    if (isCnPhone) {
      if (positionStr.length <= 3) {
        position = positionStr.length;
      } else if (positionStr.length <= 7) {
        position = positionStr.length + 1;
      } else if (positionStr.length <= 11) {
        position = positionStr.length + 2;
      } else {
        position = 13;
      }
    } else if (isCnIdCard) {
      if (positionStr.length <= 6) {
        position = positionStr.length;
      } else if (positionStr.length <= 10) {
        position = positionStr.length + 1;
      } else if (positionStr.length <= 14) {
        position = positionStr.length + 2;
      } else if (positionStr.length <= 18) {
        position = positionStr.length + 3;
      } else {
        position = 21;
      }
    } else {
      if (positionStr.length % getSeperateNum() == 0) {
        position = positionStr.length + (positionStr.length ~/ getSeperateNum()) - 1;
      } else {
        position = positionStr.length + (positionStr.length ~/ getSeperateNum());
      }
    }
    //这里格式化整个输入文本
    text = text.replaceAll(regExp, "");
    if (maxLength != null && text.length > maxLength!) {// 超出最大长度
      return oldValue;
    }
    String string = "";
    if (isCnPhone) {
      string = seperateCnPhone(text);
    } else if (isCnIdCard) {
      string = seperateIdCardNumber(text);
    } else {
      for (int i = 0; i < text.length; i++) {
        if (i != 0 && i % getSeperateNum() == 0) {
          if (text[i] != " ") {
            string = string + " ";
          }
        }
        string = string + text[i];
      }
    }
    text = string;
    return TextEditingValue(text: text,
      selection: TextSelection.fromPosition(TextPosition(
          offset: position, affinity: TextAffinity.upstream)),
    );
  }
}

/// 价格输入框和数量输入框的限制（小数点后几位）
class PrecisionLimitFormatter extends TextInputFormatter {
  final int _scale;

  PrecisionLimitFormatter(this._scale);

  RegExp exp = RegExp("[0-9.]");
  static const String POINTER = ".";
  static const String DOUBLE_ZERO = "00";

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    ///输入完全删除
    if (newValue.text.isEmpty) {
      return const TextEditingValue();
    }

    ///只允许输入小数
    if (!exp.hasMatch(newValue.text)) {
      return oldValue;
    }

    ///包含小数点的情况
    if (newValue.text.contains(POINTER)) {
      ///包含多个小数
      if (newValue.text.indexOf(POINTER) !=
          newValue.text.lastIndexOf(POINTER)) {
        return oldValue;
      }
      String input = newValue.text;
      int index = input.indexOf(POINTER);

      ///小数点后位数
      int lengthAfterPointer = input.substring(index, input.length).length - 1;

      ///小数位大于精度
      if (lengthAfterPointer > _scale) {
        return oldValue;
      }
    } else if (newValue.text.startsWith(POINTER) ||
        newValue.text.startsWith(DOUBLE_ZERO)) {
      ///不包含小数点,不能以“00”开头
      return oldValue;
    }
    return newValue;
  }
}