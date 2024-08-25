import 'package:flutter/material.dart';
import 'package:hajusput_desktop/providers/payment_provider.dart';
import 'package:hajusput_desktop/models/payment.dart';
import 'package:open_file/open_file.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:hajusput_desktop/widgets/master_screen.dart';

class ReportsScreen extends StatefulWidget {
  @override
  _ReportsScreenState createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  final _formKey = GlobalKey<FormState>();
  DateTime? _startDate;
  DateTime? _endDate;
  String? _paymentStatus;
  String? _paymentMethod;
  List<Payment> _payments = [];
  double _totalRevenue = 0.0;

  final List<String> _statusOptions = ['Pending', 'Completed', 'Failed'];
  final List<String> _methodOptions = ['Cash', 'Stripe'];
  final PaymentProvider _paymentProvider = PaymentProvider();

  void _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStartDate
          ? (_startDate ?? DateTime.now())
          : (_endDate ?? DateTime.now()),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != (isStartDate ? _startDate : _endDate)) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  Future<void> _generateReport() async {
    try {
      final searchResult = await _paymentProvider.get(filter: {
        'startDate': _startDate ?? DateTime.now().subtract(Duration(days: 30)),
        'endDate': _endDate ?? DateTime.now(),
        'paymentStatus': _paymentStatus ?? '',
        'paymentMethod': _paymentMethod ?? '',
      });

      final payments = searchResult.result;

      final totalRevenue = await _paymentProvider.getTotalRevenue(filter: {
        'startDate': _startDate ?? DateTime.now().subtract(Duration(days: 30)),
        'endDate': _endDate ?? DateTime.now(),
        'paymentStatus': _paymentStatus ?? '',
        'paymentMethod': _paymentMethod ?? '',
      });

      setState(() {
        _payments = payments;
        _totalRevenue = totalRevenue;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to generate report: ${e.toString()}')),
      );
    }
  }

  Future<void> _exportPdf() async {
    try {
      final pdfBytes = await _paymentProvider.generateFinancialReportPdf(
        _startDate ?? DateTime.now().subtract(Duration(days: 30)),
        _endDate ?? DateTime.now(),
        _paymentStatus ?? '',
        _paymentMethod ?? '',
      );

      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/financial_report.pdf');
      await file.writeAsBytes(pdfBytes);

      await OpenFile.open(file.path);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to export PDF: ${e.toString()}')),
      );
    }
  }

  Widget _buildDataTable() {
    return DataTable(
      columns: [
        DataColumn(label: Text('Payment ID')),
        DataColumn(label: Text('Amount')),
        DataColumn(label: Text('Date')),
        DataColumn(label: Text('Status')),
        DataColumn(label: Text('Method')),
      ],
      rows: _payments.map((payment) {
        return DataRow(cells: [
          DataCell(Text(payment.paymentId.toString())),
          DataCell(Text(payment.amount.toString())),
          DataCell(Text(payment.paymentDate?.toLocal().toString() ?? '')),
          DataCell(Text(payment.paymentStatus ?? '')),
          DataCell(Text(payment.paymentMethod ?? '')),
        ]);
      }).toList(),
    );
  }

  Widget _buildTotalRevenue() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        'Total Revenue: \$${_totalRevenue.toStringAsFixed(2)}',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: 'Financial Report',
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Start Date'),
                      readOnly: true,
                      onTap: () => _selectDate(context, true),
                      controller: TextEditingController(
                        text: _startDate != null
                            ? '${_startDate!.toLocal()}'.split(' ')[0]
                            : '',
                      ),
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'End Date'),
                      readOnly: true,
                      onTap: () => _selectDate(context, false),
                      controller: TextEditingController(
                        text: _endDate != null
                            ? '${_endDate!.toLocal()}'.split(' ')[0]
                            : '',
                      ),
                    ),
                    DropdownButtonFormField<String>(
                      value: _paymentStatus,
                      hint: Text('Select Payment Status'),
                      items: _statusOptions.map((status) {
                        return DropdownMenuItem(
                          value: status,
                          child: Text(status),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _paymentStatus = value;
                        });
                      },
                    ),
                    DropdownButtonFormField<String>(
                      value: _paymentMethod,
                      hint: Text('Select Payment Method'),
                      items: _methodOptions.map((method) {
                        return DropdownMenuItem(
                          value: method,
                          child: Text(method),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _paymentMethod = value;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _generateReport,
                      child: Text('Generate Report'),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _exportPdf,
                      child: Text('Export as PDF'),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  _buildTotalRevenue(),
                  Expanded(child: _buildDataTable()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
