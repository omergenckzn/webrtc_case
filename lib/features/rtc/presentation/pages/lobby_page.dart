// lib/features/rtc/presentation/pages/lobby_page.dart
import 'package:auto_route/auto_route.dart';
import 'package:dating_app/core/assets/assets.gen.dart';
import 'package:dating_app/core/global_widgets/custom_app_bar.dart';
import 'package:dating_app/core/global_widgets/primary_button.dart';
import 'package:dating_app/core/router/app_router.gr.dart';
import 'package:dating_app/features/auth/presentation/state/username_cubit.dart';
import 'package:dating_app/features/rtc/presentation/state/room_cubit/room_cubit.dart';
import 'package:dating_app/locator.dart' as di;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class LobbyView extends StatefulWidget {
  const LobbyView({super.key});
  @override
  State<LobbyView> createState() => _LobbyViewState();
}

class _LobbyViewState extends State<LobbyView> {
  final _roomCtrl = TextEditingController();
  late final RoomCubit _roomCubit;

  @override
  void initState() {
    _roomCubit = di.getIt<RoomCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final username = context.watch<UsernameCubit>().state;
    return Scaffold(
      appBar: CustomAppBar(title: 'Hello $username'),
      body: BlocConsumer<RoomCubit, RoomState>(
        bloc: _roomCubit,
        listener: (context, state) {
          if (state is RoomReady) {
            context.router.push(CallRoute(roomId: state.room.id));
          }
        },
        builder: (context, state) {
          final loading = state is RoomLoading;
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                PrimaryButton(
                  onPressed:
                      loading ? null : () => _roomCubit.create(username!),
                  text: 'Create Room',
                  isTransparent: false,
                ),
                32.verticalSpace,
                TextField(
                  controller: _roomCtrl,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Assets.icons.account.svg(),
                    ),
                    hintText: 'Room Id',
                    hintStyle: const TextStyle(color: Colors.white54),
                    filled: true,
                    fillColor: Colors.white12,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                PrimaryButton(
                  onPressed: loading
                      ? null
                      : () => _roomCubit.join(username!, _roomCtrl.text.trim()),
                  text: 'Join Room',
                  isTransparent: true,
                ),
                const SizedBox(height: 16),
                if (state is RoomError)
                  Text(
                    state.message,
                    style: const TextStyle(color: Colors.red),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
