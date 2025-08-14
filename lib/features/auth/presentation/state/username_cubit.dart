// lib/features/auth/presentation/bloc/username_cubit.dart

import 'package:flutter_bloc/flutter_bloc.dart';

class UsernameCubit extends Cubit<String?> {
  UsernameCubit() : super(null);
  void setUsername(String name) =>
      emit(name.trim().isEmpty ? null : name.trim());
  void clear() => emit(null);
}
