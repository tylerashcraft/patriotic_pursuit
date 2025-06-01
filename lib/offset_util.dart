import 'dart:ui';

class OffsetUtil {
  static Offset getScaledOffset(Offset offset, Size size) {
    return Offset(offset.dx * size.width / 1728 + size.width / 2, offset.dy * size.height / 936 + size.height / 2);
  }
}
