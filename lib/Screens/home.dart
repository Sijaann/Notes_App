import 'package:flutter/material.dart';
import 'package:notes_app/Screens/add_notes.dart';
import 'package:notes_app/Screens/update_notes.dart';
import 'package:notes_app/data/database/db_helper.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Map<String, dynamic>> data = [];
  getData() async {
    dynamic val = await DatabaseHelper.dbHelper.readRecord();
    setState(() {
      data = val;
    });
    // print(data);
  }

  @override
  Widget build(BuildContext context) {
    getData();
    // return Scaffold(
    //   body: Center(
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         ElevatedButton(
    //           onPressed: () async {
    //             await DatabaseHelper.dbHelper.insertRecord(
    //               {
    //                 DatabaseHelper.notesTitle:
    //                     "Hello this is after auto increment",
    //                 DatabaseHelper.notesBody: "This is Notes Body"
    //               },
    //             );
    //           },
    //           child: const Text("Create"),
    //         ),
    //         ElevatedButton(
    //           onPressed: () async {
    //             var readData = await DatabaseHelper.dbHelper.readRecord();
    //             print(readData);
    //           },
    //           child: const Text("Read"),
    //         ),
    //         ElevatedButton(
    //           onPressed: () {},
    //           child: const Text("Update"),
    //         ),
    //         ElevatedButton(
    //           onPressed: () {},
    //           child: const Text("Delete"),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddNotes(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text("Notes App"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              return (data.isEmpty)
                  ? const Center(
                      child: Text("No data found"),
                    )
                  : ListTile(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ViewNotes(
                              id: data[index]['id'],
                              title: data[index]["title"],
                              body: data[index]["body"],
                            ),
                          ),
                        );
                      },
                      title: Text(
                        data[index]["title"],
                        style: const TextStyle(fontSize: 18),
                      ),
                      subtitle: Text(data[index]["body"]),
                      trailing: IconButton(
                        onPressed: () async {
                          await DatabaseHelper.dbHelper.deleteRecord(1);
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                    );
            }),
      ),
    );
  }
}
