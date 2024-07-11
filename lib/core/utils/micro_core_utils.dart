import 'package:flutter/widgets.dart';

typedef WidgetBuilderArgs = Widget Function(BuildContext context, Object? args);
typedef FuncFactory<T> = T Function();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey();
