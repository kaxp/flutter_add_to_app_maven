import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension StringExtensions on String {

  String truncate({length = 7, omission = '...'}) {
    try {
      final String text = this;
      if (length >= text.length) {
        return text;
      }
      return text.replaceRange(length, text.length, omission);
    } catch (e) {
      return this;
    }
  }

  String truncateFileName({length = 12, omission = '.'}) {
    try {
      final String text = this;
      final String extension = getExtension();
      if (length >= text.length) {
        return text + extension;
      }
      return text.replaceRange(length, text.length, omission) + extension;
    } catch (e) {
      return this;
    }
  }

  String getExtension() {
    String extension = '';
    extension = split('?')[0];
    try {
      return '.${extension.split('.').last}'.toLowerCase();
    } catch (e) {
      return '';
    }
  }

  String fileName() {
    String extension = '';
    extension = split('?')[0];
    try {
      return extension.split('/').last;
    } catch (e) {
      return '';
    }
  }

  String? toAstricView(int start, int end) {
    try {
      final String test = this;
      final String result = test.replaceRange(
          start, test.length - end, '*' * (test.length - end - start));
      return result;
    } catch (e) {
      return this;
    }
  }

  String toDDMMYYYY() {
    DateTime dateTime;
    try {
      dateTime = DateTime.parse(this);
      return DateFormat('dd/MM/yyyy').format(dateTime);
    } catch (e) {
    }
    return this;
  }

  String toEEETime() {
    DateTime dateTime;
    try {
      dateTime = DateTime.parse(this);
      return DateFormat('EEE hh:mm').format(dateTime);
    } catch (e) {
    }
    return this;
  }

  String toDDMM() {
    DateTime dateTime;
    try {
      dateTime = DateTime.parse(this);
      return DateFormat('dd MMM').format(dateTime);
    } catch (e) {
    }
    return this;
  }

  String toTime() {
    DateTime dateTime;
    try {
      dateTime = DateTime.parse(this);
      return DateFormat('hh:mm a').format(dateTime);
    } catch (e) {
    }
    return this;
  }

  String toCorrectMobileNo() {
    const int n=10;
    String str = this;
    if(str.length>n){
      str = str.substring(str.length-n);
    }
    return str;
  }

  Color hexToColor() {
    return Color(int.parse(substring(1, 7), radix: 16) + 0xFF000000);
  }

  int toInt() {
    return int.parse(this);
  }

  double? toDouble() {
    return double.tryParse(replaceAll(',', '')) ?? 0.00;
  }

  String? get videoId {
    bool isValidId(String? id) => RegExp(r'^[_\-a-zA-Z\d]{11}$').hasMatch(id!);

    Uri uri;
    try {
      uri = Uri.parse(this);
    } catch (e) {
      return null;
    }
    if (!['https', 'http'].contains(uri.scheme)) {
      return null;
    }

    if (['youtube.com', 'www.youtube.com', 'm.youtube.com']
            .contains(uri.host) &&
        uri.pathSegments.isNotEmpty &&
        uri.pathSegments.first == 'watch' &&
        uri.queryParameters.containsKey('v')) {
      final videoId = uri.queryParameters['v'];
      return isValidId(videoId) ? videoId : null;
    }

    // youtu.be/xxxxxxxxxxx
    if (uri.host == 'youtu.be' && uri.pathSegments.isNotEmpty) {
      final videoId = uri.pathSegments.first;
      return isValidId(videoId) ? videoId : null;
    }

    return null;
  }

  String get thumbnail {
    return 'https://img.youtube.com/vi/$videoId/mqdefault.jpg';
  }

  DateTime? formatDateTimeFromUtc() {
    try {
      return DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(this);
    } catch (e) {
      debugPrint('DateFormat : ${e.toString}');
      return null;
    }
  }
}

extension ContextExtensions on BuildContext {
  void hideKeyboard() {
    FocusScope.of(this).requestFocus(FocusNode());
  }

  void nextEditableTextFocus() {
    do {
      FocusScope.of(this).nextFocus();
    } while (
        FocusScope.of(this).focusedChild!.context!.widget is! EditableText);
  }

  void previousEditableTextFocus() {
    do {
      FocusScope.of(this).previousFocus();
    } while (
        FocusScope.of(this).focusedChild!.context!.widget is! EditableText);
  }
}

extension NumberExtension on num {
  Widget get margin {
    return Padding(padding: EdgeInsets.all(toDouble()));
  }

  String currencyFormat() {
    final NumberFormat numberFormat =
        NumberFormat.currency(locale: 'hi_In', symbol: '₹ ');
    return numberFormat.format(this);
  }
}

extension WidgetExtension on Widget {
  Widget visibility(bool visibility) {
    return Visibility(
      visible: visibility,
      child: this,
    );
  }

  Widget get addContainer {
    return Container(
      color: Colors.yellow,
      child: this,
    );
  }

  Widget alignTo(Alignment alignment) {
    return Align(
      alignment: alignment,
      child: this,
    );
  }
}