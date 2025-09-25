import 'package:flutter/material.dart';
import 'package:neonappscase_gradproject/app/common/theme/app_colors.dart';

class AppIcons {
  //HomePage

  static final rename = Icon(
    Icons.drive_file_rename_outline,
    color: AppColors.bgwhiteBlue,
  );
  static final renameBlue = Icon(
    Icons.drive_file_rename_outline,
    color: AppColors.bgTriartry,
  );

  static final search = Icon(Icons.search, color: Colors.blue.shade400);

  static final notFountImage = Icon(
    Icons.broken_image,
    size: 50,
    color: Colors.grey,
  );

  static final clear = Icon(Icons.clear, color: Colors.blue.shade400);

  //more_vert icon
  static final moreHoriz = Icon(Icons.more_horiz, color: AppColors.bgPrimary);

  static final moreHorizBlue = Icon(
    Icons.more_horiz,
    color: AppColors.bgwhiteBlue,
  );

  //file move icons
  static final fileMove = Icon(
    Icons.move_to_inbox,
    color: AppColors.bgwhiteBlue,
  );

  static final fileMoveBlue = Icon(
    Icons.move_to_inbox,
    color: AppColors.bgTriartry,
  );

  //folder icon

  // - Medium size
  // ignore: prefer_function_declarations_over_variables
  static final folder = (BuildContext context) => Icon(
    Icons.folder,
    size: IconSizes.iconMedium,
    color: AppColors.bgPrimary,
  );
  static Icon Function(BuildContext context) folderBlue = (BuildContext context) => Icon(
    Icons.folder,
    size: IconSizes.iconMedium,
    color: AppColors.bgTriartry,
  );

  // - Large size
  static const folderLarge = Icon(
    Icons.folder,
    size: IconSizes.iconExtraLarge,
    color: AppColors.bgSmoothLight,
  );

  static Icon file(BuildContext context) {
    return Icon(
      Icons.file_copy,
      size: IconSizes.iconMedium,
      color: AppColors.bgPrimary,
    );
  }

  static Icon fileLarge(BuildContext context) {
    return Icon(
      Icons.file_copy,
      size: IconSizes.iconMedium,
      color: AppColors.bgTriartry,
    );
  }

  //list icon
  static const list = Icon(Icons.list, size: IconSizes.iconMedium);

  //grid icon
  static const grid = Icon(Icons.grid_3x3, size: IconSizes.iconMedium);

  //star icon
  static Icon star(BuildContext context) {
    return Icon(Icons.star, color: AppColors.star);
  }

  //star border icon
  static Icon starBorder(BuildContext context) {
    return Icon(Icons.star_border, color: AppColors.bgTriartry);
  }

  static Icon starBorderBlue(BuildContext context) {
    return Icon(Icons.star_border, color: AppColors.bgwhiteBlue);
  }

  //bottomnavbar
  static final home = Icon(Icons.home, size: IconSizes.iconLarge);
  static final favorite = Icon(Icons.star, size: IconSizes.iconLarge);
  static final profileXxl = Icon(Icons.person, size: IconSizes.iconXXL);
  static final profile = Icon(Icons.person, size: IconSizes.iconLarge);

  //favorite page
  static final delete = Icon(
    Icons.delete,
    size: IconSizes.iconMedium,
    color: AppColors.fail,
  );

  //file download icon

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

  static final createFolderIconData = Icons.create_new_folder;
}

class IconSizes {
  static const double iconSmall = 16.0;
  static const double iconMedium = 24.0;
  static const double iconLarge = 32.0;
  static const double iconExtraLarge = 48.0;
  static const double iconXXL = 56.0;
}
