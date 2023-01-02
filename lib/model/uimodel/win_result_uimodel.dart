import 'package:nengar/gen/assets.gen.dart';
import 'package:nengar/model/win_type.dart';

class WinResultUiModel {
  final AssetGenImage? resultImage;

  WinResultUiModel(this.resultImage);

  factory WinResultUiModel.empty() {
    return WinResultUiModel(null);
  }

  factory WinResultUiModel.from(WinType winType) {
    AssetGenImage? image;
    switch (winType) {
      case WinType.first:
        image = Assets.image.winFirstImg;
        break;
      case WinType.second:
        image = Assets.image.winSecondImg;
        break;
      case WinType.third:
        image = Assets.image.winThirdImg;
        break;
      case WinType.other:
        image = Assets.image.otherImg;
        break;
      case WinType.none:
        break;
    }
    return WinResultUiModel(image);
  }
}
