import 'package:flutter/material.dart';
import 'package:learning_sqflite/add_note_view.dart';
import 'package:learning_sqflite/edit_note_view.dart';
import 'package:learning_sqflite/sqldb.dart';

class HomeView extends StatefulWidget {
  HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  SqlDb sqlDb = SqlDb();
  List<Map> notes = [];
  bool isLoading = true;
  redData() async {
    List<Map> response = await sqlDb.getData("SELECT * FROM notes");
    notes.addAll(response);
    isLoading = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    redData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("xxxxxxxxxxxx");
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AddNoteView(),
          ));
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Home page"),
      ),
      body: ListView(
        children: [
          ElevatedButton(
              onPressed: () async {
                int response = await sqlDb.insertData(
                    "INSERT INTO 'notes' ('title','note') VALUES ('note one','Hello world')");

                print("Response ==== $response");
              },
              child: const Text("Insert data")),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
              onPressed: () async {
                List<Map> response =
                    await sqlDb.getData("SELECT * FROM 'notes'");
                print("Response ==== $response");
              },
              child: const Text("Get data")),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
              onPressed: () async {
                int response =
                    await sqlDb.deleteData("DELETE FROM 'notes' WHERE id=2");
                print("Response ==== $response");
              },
              child: const Text("Delete data")),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
              onPressed: () async {
                int response = await sqlDb.deleteData(
                    "UPDATE 'notes' SET 'note' ='dodododo' WHERE id=3");
                print("Response ==== $response");
              },
              child: const Text("Update data")),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
              onPressed: () async {
                await sqlDb.deleteMyDatabase();
                print("Response ====");
              },
              child: const Text("Delete database")),
          isLoading
              ? const Text("Loading....")
              : SizedBox(
                  height: 300,
                  child: ListView.builder(
                    itemCount: notes.length,
                    itemBuilder: (context, index) => ListTile(
                      title: Text("${notes[index]['title']}"),
                      subtitle: Text("${notes[index]['note']}"),
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => EditNoteView(
                          id: notes[index]['id'],
                          title: notes[index]['title'],
                          note: notes[index]['note'],
                        ),
                      )),
                    ),
                  ),
                )
        ],
      ),
    );
  }
}
