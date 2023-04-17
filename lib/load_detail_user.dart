import 'package:flutter/material.dart';
import 'api_data_source.dart';
import 'detail_user_model.dart';

class LoadDetailUser extends StatelessWidget {
  final int IDuser;
  const LoadDetailUser({Key? key, required this.IDuser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail User $IDuser'),
      ),
      body: Container(
        child: FutureBuilder(
          future: ApiDataSource.instance.loadDetailUser(IDuser),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasError) {
              return const Text('Error');
            }
            if (snapshot.hasData) {
              DetailUsersModel usersModel =
                  DetailUsersModel.fromJson(snapshot.data);
              return _buildSuccessSection(context, usersModel);
            }
            return _buildLoadingSection();
          },
        ),
      ),
    );
  }

  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(), //widget buat nampilin yg loding
    );
  }

  Widget _buildSuccessSection(BuildContext context, DetailUsersModel users) {
    final userData = users.data!;
    return Container(
      child: _buildItemUsers(context, userData),
    );
  }

  Widget _buildItemUsers(BuildContext context, Data userData) {
    return Container(
      child: Center(
        child: Column(children: [
          Container(
            width: 100,
            child: Image.network(userData.avatar!),
          ),
          SizedBox(
            width: 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(userData.firstName! + " " + userData.lastName!),
              Text(userData.email!)
            ],
          )
        ]),
      ),
    );
  }
}
