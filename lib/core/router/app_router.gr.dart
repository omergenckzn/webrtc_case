// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:dating_app/features/auth/presentation/pages/username_page.dart'
    as _i4;
import 'package:dating_app/features/rtc/presentation/pages/call_page.dart'
    as _i1;
import 'package:dating_app/features/rtc/presentation/pages/lobby_page.dart'
    as _i2;
import 'package:dating_app/features/splash/presentation/splash_view.dart'
    as _i3;
import 'package:flutter/material.dart' as _i6;

/// generated route for
/// [_i1.CallView]
class CallRoute extends _i5.PageRouteInfo<CallRouteArgs> {
  CallRoute({
    required String roomId,
    _i6.Key? key,
    List<_i5.PageRouteInfo>? children,
  }) : super(
          CallRoute.name,
          args: CallRouteArgs(
            roomId: roomId,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'CallRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CallRouteArgs>();
      return _i1.CallView(
        roomId: args.roomId,
        key: args.key,
      );
    },
  );
}

class CallRouteArgs {
  const CallRouteArgs({
    required this.roomId,
    this.key,
  });

  final String roomId;

  final _i6.Key? key;

  @override
  String toString() {
    return 'CallRouteArgs{roomId: $roomId, key: $key}';
  }
}

/// generated route for
/// [_i2.LobbyView]
class LobbyRoute extends _i5.PageRouteInfo<void> {
  const LobbyRoute({List<_i5.PageRouteInfo>? children})
      : super(
          LobbyRoute.name,
          initialChildren: children,
        );

  static const String name = 'LobbyRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i2.LobbyView();
    },
  );
}

/// generated route for
/// [_i3.SplashView]
class SplashRoute extends _i5.PageRouteInfo<void> {
  const SplashRoute({List<_i5.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i3.SplashView();
    },
  );
}

/// generated route for
/// [_i4.UsernameView]
class UsernameRoute extends _i5.PageRouteInfo<void> {
  const UsernameRoute({List<_i5.PageRouteInfo>? children})
      : super(
          UsernameRoute.name,
          initialChildren: children,
        );

  static const String name = 'UsernameRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i4.UsernameView();
    },
  );
}
