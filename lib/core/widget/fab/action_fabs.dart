import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:neonappscase_gradproject/app/common/constants/app_icons.dart';
import 'package:neonappscase_gradproject/app/common/router/app_router.gr.dart';
import 'package:neonappscase_gradproject/app/presentation/home/widget/dialogs/create_folder_dialog.dart';
import 'package:neonappscase_gradproject/core/widget/fab/action_fab.dart';
import 'package:neonappscase_gradproject/core/widget/fab/expandable_fab.dart';

class AnimatedFloatingActionButton extends StatelessWidget {
  const AnimatedFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ExpandableFab(
      distance: 120,
      children: [
        ActionFab(
          icon: AppIcons.createFolderIconData,
          onPressed: () {
            createFolderDialog(context);
          },
        ),

        ActionFab(
          icon: Icons.image,
          onPressed: () => context.router.push(const UploadRoute()),
        ),

        ActionFab(
          icon: Icons.upload_file,
          onPressed: () => context.router.push(const UploadFileRoute()),
        ),
      ],
    );
  }
}
