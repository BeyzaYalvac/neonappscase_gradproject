import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neonappscase_gradproject/app/presentation/splash/cubit/splash_cubit.dart';
import 'package:neonappscase_gradproject/app/presentation/splash/cubit/splash_state.dart';
import 'package:neonappscase_gradproject/app/common/theme/app_colors.dart';

class SplashDots extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SplashCubit, SplashState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(state.totalPages, (_index) {
            final bool isActive = _index == state.index;
            return GestureDetector(
              onTap: () {
                context.read<SplashCubit>().controller.animateToPage(
                  _index,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 6),
                width: isActive ? 16 : 10,
                height: isActive ? 16 : 10,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isActive ? AppColors.bgTriartry : Colors.grey[400],
                  boxShadow: isActive
                      ? [
                          BoxShadow(
                            color: Colors.blueAccent.withValues(alpha: 0.4),
                            blurRadius: 6,
                          ),
                        ]
                      : [],
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
