import 'package:auto_route/auto_route.dart';
import 'package:dating_app/core/router/app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'View,Route')
final class AppRouter extends RootStackRouter {
  AppRouter();
  @override
  List<AutoRoute> get routes => [
        CustomRoute(
            page: SplashRoute.page,
            transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
            durationInMilliseconds: 500,
            initial: true),
        CustomRoute(
          page: UsernameRoute.page,
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
          durationInMilliseconds: 500,
        ),
        CustomRoute(
          page: CallRoute.page,
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
          durationInMilliseconds: 500,
        ),
        CustomRoute(
          page: LobbyRoute.page,
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
          durationInMilliseconds: 500,
        ),
      ];
}
