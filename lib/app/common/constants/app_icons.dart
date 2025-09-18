import 'package:flutter/material.dart';
import 'package:neonappscase_gradproject/app/common/theme/app_colors.dart';

class AppIcons {
  //HomePage

  static final rename = Icon(
    Icons.drive_file_rename_outline,
    color: AppColors.bgfourtary,
  );

  static final search = Icon(Icons.search, color: Colors.blue.shade400);

  static final not_fount_image = Icon(
    Icons.broken_image,
    size: 50,
    color: Colors.grey,
  );

  static final clear = Icon(Icons.clear, color: Colors.blue.shade400);

  //folder icon

  // - Medium size
  static const folder = Icon(
    Icons.folder,
    size: IconSizes.iconMedium,
    color: AppColors.bgTriartry,
  );

  // - Large size
  static const folder_large = Icon(
    Icons.folder,
    size: IconSizes.iconExtraLarge,
    color: AppColors.bgTriartry,
  );

  //list icon
  static const list = Icon(Icons.list, size: IconSizes.iconMedium);

  //grid icon
  static const grid = Icon(Icons.grid_3x3, size: IconSizes.iconMedium);

  //star icon
  static const star = Icon(Icons.star, color: AppColors.star);

  //star border icon
  static const star_border = Icon(
    Icons.star_border,
    color: AppColors.bgTriartry,
  );

  //bottomnavbar
  static final home = Icon(Icons.home, size: IconSizes.iconLarge);
  static final favorite = Icon(Icons.star, size: IconSizes.iconLarge);
  static final profile = Icon(Icons.person, size: IconSizes.iconLarge);

  //favorite page
  static final delete = Icon(
    Icons.delete,
    size: IconSizes.iconMedium,
    color: AppColors.fail,
  );

  static final download = Icon(
    Icons.download,
    size: IconSizes.iconMedium,
    color: AppColors.success,
  );

  //fab
  static Icon close(BuildContext context) {
    return Icon(Icons.close, color: Theme.of(context).primaryColor);
  }

  static final create = Icon(Icons.add);
}

class IconSizes {
  static const double iconSmall = 16.0;
  static const double iconMedium = 24.0;
  static const double iconLarge = 32.0;
  static const double iconExtraLarge = 48.0;
}
