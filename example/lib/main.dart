import 'package:extended_image/extended_image.dart';
import 'package:extended_image_library/extended_image_library.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_candies_demo_library/flutter_candies_demo_library.dart';
import 'package:oktoast/oktoast.dart';
import 'example_route.dart';
import 'example_route_helper.dart';
import 'example_routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp() {
    clearDiskCachedImages(duration: const Duration(days: 7));
    listSourceRepository.loadData().then((bool result) {
      if (listSourceRepository.isNotEmpty)
        _imageTestUrls =
            listSourceRepository.map((TuChongItem f) => f.imageUrl).toList();
    });
  }
  final TuChongRepository listSourceRepository = TuChongRepository();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return OKToast(
        child: MaterialApp(
      title: 'ExtendedText',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      builder: (BuildContext c, Widget w) {
        ScreenUtil.init(width: 750, height: 1334, allowFontScaling: true);
        // ScreenUtil.instance =
        //     ScreenUtil(width: 750, height: 1334, allowFontScaling: true)
        //       ..init(c);
        if (!kIsWeb) {
          final MediaQueryData data = MediaQuery.of(c);
          return MediaQuery(
            data: data.copyWith(textScaleFactor: 1.0),
            child: w,
          );
        }
        return w;
      },
      initialRoute: Routes.fluttercandiesMainpage,
      onGenerateRoute: (RouteSettings settings) {
        //when refresh web, route will as following
        //   /
        //   /fluttercandies:
        //   /fluttercandies:/
        //   /fluttercandies://mainpage
        if (kIsWeb && settings.name.startsWith('/')) {
          return onGenerateRouteHelper(
            settings.copyWith(name: settings.name.replaceFirst('/', '')),
            notFoundFallback:
                getRouteResult(name: Routes.fluttercandiesMainpage).widget,
          );
        }
        return onGenerateRouteHelper(settings);
      },
    ));
  }
}

List<String> _imageTestUrls;
List<String> get imageTestUrls =>
    _imageTestUrls ??
    <String>['https://photo.tuchong.com/4870004/f/298584322.jpg'];
