// lib/features/user/presentation/pages/sign_in_view.dart
/*mport 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:dating_app/core/assets/assets.gen.dart';
import 'package:dating_app/core/global_widgets/primary_button.dart';
import 'package:dating_app/core/router/app_router.gr.dart';
import 'package:dating_app/core/theme/dating_app_color.dart';
import 'package:dating_app/features/user/domain/use_case/sign_in_user.dart';
import 'package:dating_app/features/user/presentation/state/sign_in_cubit/sign_in_cubit.dart';
import 'package:dating_app/features/user/presentation/widgets/social_button.dart';
import 'package:dating_app/locator.dart' as di;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class SignInView extends StatefulWidget implements AutoRouteWrapper {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<SignInCubit>(
      create: (context) => SignInCubit(di.getIt<SignInUser>()),
      child: this,
    );
  }
}

class _SignInViewState extends State<SignInView> {
  final _emailCtl = TextEditingController();
  final _passCtl = TextEditingController();
  bool _obscure = true;

  @override
  void dispose() {
    _emailCtl.dispose();
    _passCtl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInCubit, SignInState>(
      listener: (ctx, state) {
        if (state is SignInSuccess) {
          context.router.replaceAll([const NavbarRoute()]);
        } else if (state is SignInFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: Center(
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(32),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Spacer(),
                const Text(
                  'Merhabalar',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                8.verticalSpace,
                const Text(
                  'Tempus varius a vitae interdum id tortor elementum tristique eleifend at.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
                40.verticalSpace,
                TextField(
                  controller: _emailCtl,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Assets.icons.message.svg(),
                    ),
                    hintText: 'E-Posta',
                    hintStyle: const TextStyle(color: Colors.white54),
                    filled: true,
                    fillColor: Colors.white12,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _passCtl,
                  obscureText: _obscure,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Assets.icons.unlock.svg(),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscure ? Icons.visibility_off : Icons.visibility,
                        color: Colors.white54,
                      ),
                      onPressed: () => setState(() => _obscure = !_obscure),
                    ),
                    hintText: 'Şifre',
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

                // Forgot
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(padding: EdgeInsets.zero),
                    child: const Text(
                      'Şifremi unuttum',
                      style: TextStyle(
                        color: Colors.white,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
                24.verticalSpace,

                BlocBuilder<SignInCubit, SignInState>(
                  builder: (ctx, state) {
                    final isLoading = state is SignInLoading;
                    return PrimaryButton(
                      text: 'Giriş Yap',
                      isLoading: isLoading,
                      onPressed: () async {
                        unawaited(
                          ctx.read<SignInCubit>().signIn(
                                email: _emailCtl.text.trim(),
                                password: _passCtl.text,
                              ),
                        );
                      },
                    );
                  },
                ),
                const SizedBox(height: 24),

                // Social
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SocialButton(icon: Assets.icons.google.svg(), onTap: () {}),
                    SocialButton(icon: Assets.icons.apple.svg(), onTap: () {}),
                    SocialButton(
                        icon: Assets.icons.facebook.svg(), onTap: () {}),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Bir hesabın yok mu?',
                      style: TextStyle(
                        color: Colors.white.withValues(
                          alpha: 0.5,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        context.router.replaceAll([const RegisterRoute()]);
                      },
                      child: Text(
                        'Kayıt Ol!',
                        style: TextStyle(
                          color: context.datingAppColor.antiFlashWhite,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
*/