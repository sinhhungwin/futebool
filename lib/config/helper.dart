import 'package:flutter/material.dart';

const kMaxImgListLength = 6;
const String kImgPlaceholderUrl =
    'https://vn112.com/wp-content/uploads/2018/01/pxsolidwhiteborderedsvg-15161310048lcp4.png';

enum Result { win, draw, loss }

enum ViewState { busy, retrieved, error }

dump(object) => debugPrint("\n\n$object");
