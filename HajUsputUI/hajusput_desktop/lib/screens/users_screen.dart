import 'package:flutter/material.dart';
import 'package:hajusput_desktop/models/search_result.dart';
import 'package:hajusput_desktop/models/user.dart';
import 'package:hajusput_desktop/providers/user_provider.dart';
import 'package:provider/provider.dart';

import '../widgets/master_screen.dart';

class UsersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: 'Users',
      body: UsersBody(),
    );
  }
}

class UsersBody extends StatefulWidget {
  @override
  _UsersBodyState createState() => _UsersBodyState();
}

class _UsersBodyState extends State<UsersBody> {
  late UserProvider _userProvider;
  @override
    SearchResult<User>? result;
@override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _userProvider = context.read<UserProvider>();
  }
  
    
     
    
  
  
  _asyncMethod() async{
    var data = await _userProvider.get();

    setState(() {
      result = data;
    });
  }

  @override
  Widget build(BuildContext context) {
   return Container(
        child: Column(children: [_buildDataListView()]),
      );
  }
   Widget _buildDataListView(){
   
    return Expanded(
        child: SingleChildScrollView(
      child: DataTable(
          columns: [
            const DataColumn(
              label: Expanded(
                child: Text(
                  'Name',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            const DataColumn(
              label: Expanded(
                child: Text(
                  'Surname',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            const DataColumn(
              label: Expanded(
                child: Text(
                  'Email',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
          ],
          rows: result?.result
                  .map((User e) => DataRow(
                          // onSelectChanged: (selected) => {
                          //       if (selected == true)
                          //         {
                          //           Navigator.of(context).push(
                          //             MaterialPageRoute(
                          //               builder: (context) =>
                          //                   UsersScreen(
                          //                 user: e,
                          //               ),
                          //             ),
                          //           )
                          //         }
                          //     },
                          cells: [
                            DataCell(Text(e.firstName ?? "")),
                            DataCell(Text(e.lastName ?? "")),
                            DataCell(Text(e.email)),
                            
                          ]))
                  .toList() ??
              []),
    ));
  }
  
}

