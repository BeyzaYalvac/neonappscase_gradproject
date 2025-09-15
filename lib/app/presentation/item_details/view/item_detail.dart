import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:neonappscase_gradproject/core/widget/appBar/custom_appbar.dart';

@RoutePage()
class ItemDetailView extends StatelessWidget {
  final item;
  const ItemDetailView({super.key, this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Column(
        children: [Text(item.name, style: TextStyle(color: Colors.black))],
      ),
    );
  }
}
