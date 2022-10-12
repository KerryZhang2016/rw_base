import 'dart:math';

import 'decimal_util.dart';

class MathUtil {

  static Decimal setScale(Decimal decimal, int scale, Decimal Function(Decimal decimal) roundMethod) {
    Decimal scaleVal = Decimal.fromInt(pow(10, scale).toInt());
    return roundMethod(decimal * scaleVal) / scaleVal;
  }

  static Decimal setScaleRoundDown(Decimal decimal, int scale) => setScale(decimal, scale, (val) => val.floor());

  static Decimal setScaleRoundUp(Decimal decimal, int scale) => setScale(decimal, scale, (val) => val.ceil());

  static Decimal setScaleRound(Decimal decimal, int scale) => setScale(decimal, scale, (val) => val.round());
}