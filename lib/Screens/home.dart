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
        title: const Text("Notes"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index) {
            return (data.isEmpty)
                ? const Center(
                    child: Text("No data found"),
                  )
                : Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: ListTile(
                      onTap: () {
                        // print(data);
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
                      subtitle: (data[index]["body"].length) < 40
                          ? Text(data[index]['body'])
                          : Text('${data[index]["body"]}'.substring(0, 40)),
                      trailing: IconButton(
                        onPressed: () async {
                          await DatabaseHelper.dbHelper
                              .deleteRecord(data[index]['id']);
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  );
          },
        ),
      ),
    );
  }
}
