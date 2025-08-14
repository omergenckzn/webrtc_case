import 'package:dating_app/core/network/auth_redirector.dart';
import 'package:dating_app/core/router/app_router.dart';
import 'package:dating_app/core/router/observers/custom_route_observer.dart';
import 'package:dating_app/core/theme/dating_app_color.dart';
import 'package:dating_app/features/auth/presentation/state/username_cubit.dart';
import 'package:dating_app/features/rtc/domain/use_case/create_room.dart';
import 'package:dating_app/features/rtc/domain/use_case/join_room.dart';
import 'package:dating_app/features/rtc/domain/use_case/leave_room.dart';
import 'package:dating_app/features/rtc/domain/use_case/toggle_camera.dart';
import 'package:dating_app/features/rtc/domain/use_case/toggle_mic.dart';
import 'package:dating_app/features/rtc/presentation/state/call_bloc/call_bloc.dart';
import 'package:dating_app/features/rtc/presentation/state/room_cubit/room_cubit.dart';
import 'package:dating_app/flavors.dart';
import 'package:dating_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dating_app/locator.dart' as di;

class DatingApp extends StatefulWidget {
  DatingApp({super.key}) : _appRouter = AppRouter();

  final AppRouter _appRouter;

  @override
  State<DatingApp> createState() => _DatingAppState();
}

class _DatingAppState extends State<DatingApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UsernameCubit(),
        ),
        BlocProvider(
          create: (context) => CallBloc(
            leaveRoom: di.getIt<LeaveRoom>(),
            toggleCamera: di.getIt<ToggleCamera>(),
            toggleMic: di.getIt<ToggleMic>(),
          ),
        ),
        BlocProvider(
          create: (context) => RoomCubit(
            leaveRoom: di.getIt<LeaveRoom>(),
            createRoom: di.getIt<CreateRoom>(),
            joinRoom: di.getIt<JoinRoom>(),
          ),
        ),
      ],
      child: ScreenUtilInit(
        minTextAdapt: true,
        child: Builder(
          builder: (context) {
            AuthRedirector().context = context;
            return MaterialApp.router(
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,
              debugShowCheckedModeBanner: false,
              title: F.title,
              theme: ThemeData.light().copyWith(
                scaffoldBackgroundColor: const Color(0xFF111111),
                extensions: [const DatingAppColor()],
              ),
              builder: (context, child) {
                return Stack(
                  children: [
                    if (child != null) child,
                  ],
                );
              },
              routerConfig: widget._appRouter.config(
                navigatorObservers: () => [
                  CustomRouteObserver(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
