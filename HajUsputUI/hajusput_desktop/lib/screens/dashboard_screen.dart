import 'package:flutter/material.dart';
import 'package:hajusput_desktop/providers/payment_provider.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../providers/ride_provider.dart';
import '../widgets/master_screen.dart';
import 'package:fl_chart/fl_chart.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final rideProvider = Provider.of<RideProvider>(context);
    final paymentProvider = Provider.of<PaymentProvider>(context);

    return MasterScreen(
      title: 'Dashboard',
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildOverviewSection(
                context, userProvider, rideProvider, paymentProvider),
            SizedBox(height: 16),
            _buildDetailedSection(context, rideProvider),
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewSection(BuildContext context, UserProvider userProvider,
      RideProvider rideProvider, PaymentProvider paymentProvider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: _buildDashboardCard(
            context: context,
            title: 'Total Users',
            futureValue: userProvider.getTotalUsers(),
            icon: Icons.people,
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: _buildDashboardCard(
            context: context,
            title: 'Revenue',
            futureValue: paymentProvider
                .getTotalRevenue(filter: {'paymentStatus': 'completed'}),
            icon: Icons.attach_money,
            isCurrency: true,
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: _buildDashboardCard(
            context: context,
            title: 'Total Distance',
            futureValue: rideProvider.getTotalDistanceTraveled(),
            icon: Icons.map,
            isDistance: true,
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: _buildDashboardCard(
            context: context,
            title: 'Average Distance',
            futureValue: rideProvider.getAverageDistanceTraveled(),
            icon: Icons.directions_run,
            isDistance: true,
          ),
        ),
      ],
    );
  }

  Widget _buildDetailedSection(
      BuildContext context, RideProvider rideProvider) {
    return Card(
      color: Colors.white70,
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: _buildDashboardCard(
                context: context,
                title: 'Total Rides',
                futureValue: rideProvider.getTotalRides(),
                icon: Icons.directions_car,
              ),
            ),
            SizedBox(width: 16),
            // This Row wraps the pie chart and legend
            Expanded(
              flex: 3,
              child: Row(
                children: [
                  // Pie chart
                  Flexible(
                    child: _buildRidePieChart(rideProvider),
                  ),
                  // Legend
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLegendItem(Colors.blue, 'Scheduled'),
                      _buildLegendItem(Colors.red, 'Cancelled'),
                      _buildLegendItem(Colors.green, 'Archived'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardCard({
    required BuildContext context,
    required String title,
    required Future<dynamic> futureValue,
    required IconData icon,
    bool isCurrency = false,
    bool isDistance = false,
  }) {
    return Card(
      elevation: 6,
      color: Colors.lightGreen,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<dynamic>(
          future: futureValue,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(color: Colors.white);
            } else if (snapshot.hasError) {
              return Text('Error', style: TextStyle(color: Colors.white));
            } else {
              String value = isCurrency
                  ? '\$${snapshot.data.toString()}'
                  : isDistance
                      ? '${snapshot.data.toString()} km'
                      : snapshot.data.toString();
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(icon, size: 40, color: Colors.white),
                  SizedBox(height: 16),
                  Text(
                    title,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                  SizedBox(height: 8),
                  Text(
                    value,
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          color: color,
        ),
        SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildRidePieChart(RideProvider rideProvider) {
    return FutureBuilder<Map<String, int>>(
      future: rideProvider.getRideAnalysis(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error loading ride analysis'));
        } else {
          final data = snapshot.data!;
          final scheduled = data["Scheduled"] ?? 0;
          final cancelled = data["Cancelled"] ?? 0;
          final archived = data["Archived"] ?? 0;
          final total = scheduled + cancelled + archived;

          return SizedBox(
            height: 300, // Adjust the height as needed
            child: PieChart(
              PieChartData(
                sectionsSpace: 0, // Remove the space between sections
                borderData: FlBorderData(show: false), // Remove borders
                centerSpaceRadius: 50, // Make space for percentage display
                sections: [
                  PieChartSectionData(
                    color: Colors.blue,
                    value: scheduled.toDouble(),
                    title:
                        '${(scheduled / total * 100).toStringAsFixed(1)}%', // Percentage
                    radius: 50,
                    titleStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  PieChartSectionData(
                    color: Colors.red,
                    value: cancelled.toDouble(),
                    title:
                        '${(cancelled / total * 100).toStringAsFixed(1)}%', // Percentage
                    radius: 50,
                    titleStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  PieChartSectionData(
                    color: Colors.green,
                    value: archived.toDouble(),
                    title:
                        '${(archived / total * 100).toStringAsFixed(1)}%', // Percentage
                    radius: 50,
                    titleStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
