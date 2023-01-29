import 'package:flutter/cupertino.dart';
import 'package:nengar/gen/assets.gen.dart';
import 'package:nengar/model/win_type.dart';

class WinResultUiModel {
  final ImageProvider? resultImage;

  WinResultUiModel(this.resultImage);

  factory WinResultUiModel.empty() {
    return WinResultUiModel(null);
  }

  factory WinResultUiModel.from(WinType winType) {
    ImageProvider? image;
    switch (winType) {
      case WinType.first:
        image = Assets.image.winFirstImg.provider();
        break;
      case WinType.second:
        image = Assets.image.winSecondImg.provider();
        break;
      case WinType.third:
        image = Assets.image.winThirdImg.provider();
        break;
      case WinType.other:
        image = Assets.image.otherImg.provider();
        break;
      case WinType.none:
        break;
    }
    return WinResultUiModel(image);
  }
}
