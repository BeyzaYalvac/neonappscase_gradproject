import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neonappscase_gradproject/app/common/constants/spacing/app_mediaqueries.dart';
import 'package:neonappscase_gradproject/app/common/theme/app_colors.dart';
import 'package:neonappscase_gradproject/app/presentation/profile/cubit/profile_cubit.dart';
import 'package:neonappscase_gradproject/app/presentation/profile/cubit/profile_state.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final h = AppMediaQuery.screenHeight(context);
    final w = AppMediaQuery.screenWidth(context);
    final avatarRadius = w * 0.14;

    String _fmtBytes(num b) {
      const k = 1024;
      const units = ['B', 'KB', 'MB', 'GB', 'TB'];
      int i = 0;
      double v = b.toDouble();
      while (v >= k && i < units.length - 1) {
        v /= k;
        i++;
      }
      return "${v.toStringAsFixed(1)} ${units[i]}";
    }

    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        Map<String, dynamic>? account = state.acountInfos?["data"];
        print(account.toString());
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // HEADER + AVATAR STACK
            SizedBox(
              height: h * 0.20, // avatar taşması için ekstra yükseklik
              child: Stack(
                alignment: Alignment.topCenter,
                clipBehavior: Clip.none,
                children: [
                  // Header arka plan
                  Container(
                    height: h * 0.12,
                    width: w * 0.9,
                    margin: EdgeInsets.fromLTRB(
                      w * 0.05,
                      h * 0.08,
                      w * 0.05,
                      0,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.bgPrimary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(top: h * 0.06),
                      child: Center(
                        child: Text(
                          account?["email"] ?? "Kullanıcı Adı",
                          style: TextStyle(
                            fontSize: w * 0.04,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textMedium,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Avatar (yarısı header'ın üstünden taşıyor)
                  Positioned(
                    top: h * 0.01,
                    child: CircleAvatar(
                      radius: avatarRadius,
                      backgroundColor: AppColors.bgQuaternary,
                      child: Icon(
                        Icons.person,
                        size: avatarRadius,
                        color: AppColors.textWhite,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: h * 0.02), // avatar altına boşluk

            Container(
              height: h * 0.08,
              width: w * 0.9,
              decoration: BoxDecoration(
                color: AppColors.bgPrimary,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.bgQuaternary),
              ),

              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Column(
                  children: [
                    Text("Current Storage:"),
                    LinearProgressIndicator(
                      minHeight: h * 0.02,
                      value: account?["statsCurrent"]["storage"] != null
                          ? account!["statsCurrent"]["storage"] / 100000000
                          : 0.0,
                      backgroundColor: AppColors.bgQuaternary,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppColors.bgTriartry,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: h * 0.02), // avatar altına boşluk
            // Stats (Folder & File)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: w * 0.05),
              child: Row(
                children: [
                  Expanded(
                    child: _StatCard(
                      title: 'Folder',
                      value:
                          account?["statsCurrent"]["folderCount"].toString() ??
                          "0",
                      height: h * 0.18,
                      color: AppColors.bgQuaternary,
                    ),
                  ),
                  SizedBox(width: w * 0.04),
                  Expanded(
                    child: _StatCard(
                      title: 'File',
                      value:
                          account?["statsCurrent"]["fileCount"].toString() ??
                          "0",

                      height: h * 0.18,
                      color: AppColors.bgQuaternary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final double height;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.height,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final w = AppMediaQuery.screenWidth(context);

    return Container(
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              value,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: w * 0.18),
            ),
            const SizedBox(height: 4),
            Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}
