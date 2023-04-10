import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Container search() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 8),
        child: TextFormField(
          decoration: InputDecoration(
              icon: Icon(Icons.search),
              hintText: "Search",
              border: InputBorder.none),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: search(),
      ),
      body: ListView.builder(
        itemBuilder: ((context, index) {
          return ListTile(
            leading: Icon(Icons.home),
            title: Text("Name"),
            trailing: IconButton(onPressed: () {}, icon: Icon(Icons.info)),
          );
        }),
        itemCount: 1,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.pushNamed(context, "video");
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
