import 'package:flutter/material.dart';
import 'package:neonappscase_gradproject/app/presentation/home/cubit/home_state.dart';
import 'package:neonappscase_gradproject/app/presentation/home/widget/alerts/move_file_alert.dart';

Future<dynamic> moveFileDialog(BuildContext context, HomeState state, file) {
    return showDialog(
                          context: context,
                          builder: (context) {
                            final items = state.folders.map((f) {
                              final id = f.fldId.toString();
                              return DropdownMenuItem<String>(
                                value: id,
                                child: Text(
                                  f.name,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              );
                            }).toList();

                            return MoveFileAlert(items: items, file: file);
                          },
                        );
  }
