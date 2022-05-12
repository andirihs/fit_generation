import 'package:fit_generation/src/util_widget/custom_app_bar_widget.dart';
import 'package:fit_generation/src/util_widget/pop_handle_widget.dart';
import 'package:fit_generation/src/weight_tracker_feat/weight_entity.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class WeightTrackerView extends ConsumerWidget {
  WeightTrackerView({Key? key}) : super(key: key);

  static const String routeName = "weight_tracker";

  final List<WeightEntity> weightEntries = [
    WeightEntity(weight: 79.3, recordDate: DateTime(2022, 03, 1)),
    WeightEntity(weight: 74.8, recordDate: DateTime(2022, 04, 1)),
    WeightEntity(weight: 71.5, recordDate: DateTime(2022, 05, 1)),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _dateFormat = DateFormat("dd.MM.yyyy");
    final _monthDateFormat = DateFormat("MMM");

    return Scaffold(
      appBar: CustomAppBar(
        title: routeName,
        leading: getCancelWidgetIfPopNotPossible(context: context),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SfCartesianChart(
                // Initialize category axis
                primaryXAxis: CategoryAxis(),
                legend: Legend(isVisible: true),
                series: <LineSeries<WeightEntity, String>>[
                  LineSeries<WeightEntity, String>(
                    isVisible: true,
                    isVisibleInLegend: false,
                    legendItemText: "weight",
                    yAxisName: "weight",
                    xAxisName: "Month",
                    // Bind data source
                    dataSource: weightEntries,
                    xValueMapper: (weightEntry, _) =>
                        _monthDateFormat.format(weightEntry.recordDate),
                    yValueMapper: (weightEntry, _) => weightEntry.weight,
                  )
                ]),
            // WeightLineChartWidget(weightEntries: weightEntries),
            const SizedBox(height: 40),
            SizedBox(
              height: 40,
              child: Text(
                "Bisher erfasste Daten:",
                style: Theme.of(context).textTheme.subtitle1,
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: ListView.separated(
                /// Providing a restorationId allows the ListView to restore the
                /// scroll position when a user leaves and returns to the app after it
                /// has been killed while running in the background.
                // ToDo: not working
                restorationId: routeName,
                itemCount: weightEntries.length,
                itemBuilder: (BuildContext context, int index) {
                  final item = weightEntries[index];

                  return ListTile(
                    title: Text(_dateFormat.format(item.recordDate)),
                    trailing: Text(
                      "${item.weight} Kg",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    dense: false,
                    // contentPadding: EdgeInsets.zero,
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(height: 0);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
//
// class WeightLineChartWidget extends ConsumerWidget {
//   const WeightLineChartWidget({required this.weightEntries, Key? key})
//       : super(key: key);
//
//   final List<WeightEntity> weightEntries;
//
//   LineChartData get weightData => LineChartData(
//         // lineTouchData: lineTouchData1,
//         // gridData: gridData,
//         // titlesData: titlesData1,
//         // borderData: borderData,
//         lineBarsData: [
//           LineChartBarData(
//             spots: weightEntries
//                 .map((e) => FlSpot(e.weight, e.recordDate.month.toDouble()))
//                 .toList(),
//           ),
//         ],
//         minX: 0,
//         maxX: 200,
//         maxY: 12,
//         minY: 0,
//       );
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return LineChart(weightData);
//   }
// }
