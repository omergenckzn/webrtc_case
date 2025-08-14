// lib/core/di/injector.dart
import 'package:dating_app/features/rtc/data/data_source/signaling_data_source.dart';
import 'package:dating_app/features/rtc/data/repository/signaling_repository.dart';
import 'package:dating_app/features/rtc/domain/repositories/signaling_repository.dart';
import 'package:dating_app/features/rtc/domain/use_case/create_room.dart';
import 'package:dating_app/features/rtc/domain/use_case/join_room.dart';
import 'package:dating_app/features/rtc/domain/use_case/leave_room.dart';
import 'package:dating_app/features/rtc/domain/use_case/toggle_camera.dart';
import 'package:dating_app/features/rtc/domain/use_case/toggle_mic.dart';
import 'package:dating_app/features/rtc/presentation/state/call_bloc/call_bloc.dart';
import 'package:dating_app/features/rtc/presentation/state/room_cubit/room_cubit.dart';
import 'package:dating_app/services/share_service.dart';
import 'package:dating_app/services/web_rtc_service.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

// ===== Common Services =====
import 'package:dating_app/services/token_service.dart';
import 'package:dating_app/services/network_service.dart';
import 'package:dating_app/services/logger_service.dart';

// ===== RTC/Video Call =====

// (Optional) If you use AutoRoute AppRouter in DI, uncomment these:
// import 'package:dating_app/core/router/app_router.dart';

final getIt = GetIt.instance;

void setup() {
  getIt
    // ===== Core / Services =====
    ..registerLazySingleton<Dio>(Dio.new)
    ..registerLazySingleton<TokenService>(TokenService.new)
    ..registerLazySingleton<NetworkService>(
      () => NetworkService(getIt<Dio>()),
    )
    ..registerLazySingleton<LoggerService>(LoggerService.new)
    ..registerLazySingleton<ShareService>(ShareService.new)

    // ===== RTC / Video Call Layer =====
    ..registerLazySingleton<WebRTCService>(WebRTCService.new)
    ..registerLazySingleton<SignalingDataSource>(
      FirestoreSignalingDataSource.new,
    )
    ..registerLazySingleton<SignalingRepository>(
      () => SignalingRepositoryImpl(
        getIt<SignalingDataSource>(),
        getIt<WebRTCService>(),
      ),
    )

    // Use Cases
    ..registerFactory<CreateRoom>(
      () => CreateRoom(getIt<SignalingRepository>()),
    )
    ..registerFactory<JoinRoom>(() => JoinRoom(getIt<SignalingRepository>()))
    ..registerFactory<LeaveRoom>(() => LeaveRoom(getIt<SignalingRepository>()))
    ..registerFactory<ToggleMic>(() => ToggleMic(getIt<SignalingRepository>()))
    ..registerFactory<ToggleCamera>(
      () => ToggleCamera(getIt<SignalingRepository>()),
    )

    // Blocs / Cubits
    ..registerFactory<RoomCubit>(
      () => RoomCubit(
        createRoom: getIt<CreateRoom>(),
        joinRoom: getIt<JoinRoom>(),
        leaveRoom: getIt<LeaveRoom>(),
      ),
    )
    ..registerFactory<CallBloc>(
      () => CallBloc(
        toggleMic: getIt<ToggleMic>(),
        toggleCamera: getIt<ToggleCamera>(),
        leaveRoom: getIt<LeaveRoom>(),
      ),
    );
}
