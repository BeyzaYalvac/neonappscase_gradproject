import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neonappscase_gradproject/app/presentation/upload/cubit/upload_cubit.dart';
import 'package:neonappscase_gradproject/app/presentation/upload/cubit/upload_state.dart';
import 'package:neonappscase_gradproject/app/presentation/upload/widget/empty_state_card.dart';
import 'package:neonappscase_gradproject/core/widget/appBar/custom_appbar.dart';

@RoutePage()
class UploadView extends StatelessWidget {
  const UploadView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UploadCubit, UploadState>(
      builder: (context, state) {
        return Scaffold(appBar: CustomAppBar(), body: PhotoUploadColumn());
      },
    );
  }
}
