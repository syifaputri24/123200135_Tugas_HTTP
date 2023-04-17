import 'package:flutter/material.dart';
import 'users_model.dart';
import 'api_data_source.dart';
import 'load_detail_user.dart';

class PageListUsers extends StatefulWidget {
  const PageListUsers({super.key});

  @override
  State<PageListUsers> createState() => _PageListUsersState();
}

class _PageListUsersState extends State<PageListUsers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List dari User"),
      ),
      body: _buildListUsersBody(),
    );
  }

  Widget _buildListUsersBody() {
    return Container(
      child: FutureBuilder(
        future: ApiDataSource.instance.loadUsers(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            // Jika data ada error maka akan ditampilkan hasil error
            return _buildErrorSection();
          }
          if (snapshot.hasData) {
            // Jika data ada dan berhasil maka akan ditampilkan hasil datanya
            UsersModel usersModel = UsersModel.fromJson(snapshot.data);
            return _buildSuccessSection(usersModel);
          }
          return _buildLoadingSection();
        },
      ),
    );
  }

  Widget _buildErrorSection() {
    return Text("Error");
  }

  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildSuccessSection(UsersModel data) {
    return ListView.builder(
      itemCount: data.data!.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildItemUsers(data.data![index]);
      },
    );
  }

  Widget _buildItemUsers(Data userData) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LoadDetailUser(IDuser: userData.id!),
            ));
      },
      child: Card(
        child: Row(children: [
          Container(
            width: 100,
            child: Image.network(userData.avatar!),
          ),
          SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
