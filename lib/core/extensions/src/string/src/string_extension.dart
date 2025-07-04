import 'dart:ui' as ui;

import 'package:flutter/material.dart';

/// Size string extension.
extension SizeStringExt on String? {
  /// Get the basic size of the text.
  ///
  /// ```dart
  /// Size size = 'Hello'.getSize(style: TextStyle(fontSize: 14));
  /// ```
  /// * `style`: thuộc tính văn bản như fontSize, fontWeight, ...
  /// * `minWidth`: chiều dài 1 dòng tối thiểu của văn bản
  /// * `maxWidth`: chiều dài 1 dòng tối đa của văn bản
  /// * `textAlign`: canh lề văn bản theo chiều ngang
  /// * `textScaleFactor`: Tỉ lệ scale kích thước chữ. Ví dụ nếu hệ số tỷ lệ văn bản là 1,5, văn bản sẽ lớn hơn 50% so với kích thước phông chữ được chỉ định.
  /// * `maxLines`: số lượng dòng tối đa của văn bản
  /// * `ellipsis`: kí tự mặc định … , dùng để hiển thị văn bản vượt quá giới hạn tối đa nếu có thiết lập [TextOverflow.ellipsis]
  /// * `locale`: ngôn ngữ được sử dụng để chọn các nét tượng trưng theo vùng
  /// * `strutStyle`: thuộc tính chiều cao tối thiểu cho tổng thể các dòng văn bản, tham khảo ở https://api.flutter.dev/flutter/painting/StrutStyle-class.html
  /// * `textDirection`: hướng xuất văn bản theo chiều từ trái sang phải hoặc ngược lại (Arabic, Hebrew)
  Size getSize({
    required TextStyle style,
    double minWidth = 0,
    double maxWidth = double.infinity,
    TextAlign textAlign = TextAlign.start,
    TextScaler textScaler = TextScaler.noScaling,
    int? maxLines,
    String? ellipsis,
    Locale? locale,
    StrutStyle? strutStyle,
    ui.TextDirection? textDirection = ui.TextDirection.ltr,
  }) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: this, style: style),
      textAlign: textAlign,
      textScaler: textScaler,
      maxLines: maxLines,
      ellipsis: ellipsis,
      locale: locale,
      strutStyle: strutStyle,
      textDirection: textDirection,
    )..layout(
        minWidth: minWidth,
        maxWidth: maxWidth,
      );
    return textPainter.size;
  }
}
