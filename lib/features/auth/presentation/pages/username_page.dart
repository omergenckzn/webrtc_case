// lib/features/auth/presentation/pages/username_page.dart
import 'package:auto_route/auto_route.dart';
import 'package:dating_app/core/assets/assets.gen.dart';
import 'package:dating_app/core/global_widgets/custom_app_bar.dart';
import 'package:dating_app/core/global_widgets/primary_button.dart';
import 'package:dating_app/core/router/app_router.gr.dart';
import 'package:dating_app/features/auth/presentation/state/username_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class UsernameView extends StatefulWidget {
  const UsernameView({super.key});
  @override
  State<UsernameView> createState() => _UsernameViewState();
}

class _UsernameViewState extends State<UsernameView> {
  final _ctrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Select Username',
        canPop: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _ctrl,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Assets.icons.addUser.svg(),
                ),
                hintText: 'Username',
                hintStyle: const TextStyle(color: Colors.white54),
                filled: true,
                fillColor: Colors.white12,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            32.verticalSpace,
            PrimaryButton(
              text: 'Continue',
              onPressed: () async {
                context.read<UsernameCubit>().setUsername(_ctrl.text);
                if (context.read<UsernameCubit>().state != null) {
                  context.router.push(const LobbyRoute());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
