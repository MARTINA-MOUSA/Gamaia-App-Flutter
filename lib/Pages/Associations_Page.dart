import 'package:flutter/material.dart';

class AssociationsPage extends StatelessWidget {
  // بيانات تجريبية، يمكن استبدالها ببيانات من API لاحقاً
  final List<Map<String, String>> associations = [
    {
      'name': 'جمعية الخير',
      'role': 'عضو',
      'status': 'مفعلة',
    },
    {
      'name': 'جمعية المستقبل',
      'role': 'إداري',
      'status': 'قيد الانتظار',
    },
    {
      'name': 'جمعية الرحمة',
      'role': 'عضو',
      'status': 'مرفوضة',
    },
  ];

  Color getStatusColor(String status) {
    switch (status) {
      case 'مفعلة':
        return Colors.green;
      case 'قيد الانتظار':
        return Colors.orange;
      case 'مرفوضة':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('الجمعيات المرتبطة'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: associations.length,
        itemBuilder: (context, index) {
          final item = associations[index];
          return Card(
            margin: EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              title: Text(item['name']!),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('الدور: ${item['role']}'),
                  Text(
                    'الحالة: ${item['status']}',
                    style: TextStyle(color: getStatusColor(item['status']!)),
                  ),
                ],
              ),
              trailing: Icon(Icons.chevron_right),
            ),
          );
        },
      ),
    );
  }
}
