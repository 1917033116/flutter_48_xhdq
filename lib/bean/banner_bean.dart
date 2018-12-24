import 'package:flutter_48_xhdq/widget/BannerWithEval.dart';

class BannerBean extends BannerWithEval{
  String imgPath;
  String title;

  BannerBean(this.imgPath, this.title);

  @override
  get bannerUrl => imgPath;
}