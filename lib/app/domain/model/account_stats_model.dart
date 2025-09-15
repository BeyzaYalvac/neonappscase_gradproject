import 'package:equatable/equatable.dart';

class AccountStatsModel extends Equatable {
  final String downloads;
  final String profitViews;
  final String viewsAdb;
  final String sales;
  final String profitSales;
  final String profitRefs;
  final String profitSite;
  final String views;
  final String refs;
  final String day;
  final String profitTotal;
  final String viewsPrem;

  const AccountStatsModel({
    required this.downloads,
    required this.profitViews,
    required this.viewsAdb,
    required this.sales,
    required this.profitSales,
    required this.profitRefs,
    required this.profitSite,
    required this.views,
    required this.refs,
    required this.day,
    required this.profitTotal,
    required this.viewsPrem,
  });

  factory AccountStatsModel.fromMap(Map<String, dynamic> map) {
    return AccountStatsModel(
      downloads: map['downloads']?.toString() ?? '0',
      profitViews: map['profit_views']?.toString() ?? '0.0',
      viewsAdb: map['views_adb']?.toString() ?? '0',
      sales: map['sales']?.toString() ?? '0',
      profitSales: map['profit_sales']?.toString() ?? '0.0',
      profitRefs: map['profit_refs']?.toString() ?? '0.0',
      profitSite: map['profit_site']?.toString() ?? '0.0',
      views: map['views']?.toString() ?? '0',
      refs: map['refs']?.toString() ?? '0',
      day: map['day']?.toString() ?? '',
      profitTotal: map['profit_total']?.toString() ?? '0.0',
      viewsPrem: map['views_prem']?.toString() ?? '0',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'downloads': downloads,
      'profit_views': profitViews,
      'views_adb': viewsAdb,
      'sales': sales,
      'profit_sales': profitSales,
      'profit_refs': profitRefs,
      'profit_site': profitSite,
      'views': views,
      'refs': refs,
      'day': day,
      'profit_total': profitTotal,
      'views_prem': viewsPrem,
    };
  }

  @override
  List<Object?> get props => [
        downloads,
        profitViews,
        viewsAdb,
        sales,
        profitSales,
        profitRefs,
        profitSite,
        views,
        refs,
        day,
        profitTotal,
        viewsPrem,
      ];
}
