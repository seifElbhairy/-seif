
import 'package:flutter/material.dart';
import 'package:mode/provider/prov.dart';
import 'package:mode/screen/scre.dart';
import 'package:mode/widget/wedf.dart';
import 'package:provider/provider.dart';
class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan[400],
      body: Container(
        padding:
        const EdgeInsets.only(top: 60, left: 20, right: 20, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.playlist_add_check, size: 40, color: Colors.white),
                Text(
                  "Todolist....Saif",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Consumer<TaskProvider>(
              builder: (context, taskObject, child) {
                final total = taskObject.data?.total ?? 0;

                return Text(
                  "$total Add",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                height: 300,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: Consumer<TaskProvider>(
                    builder: (context, taskObject, child) {
                      final tasks = taskObject.data?.tasks;

                      if (tasks == null) {
                        taskObject.getAllData();
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        return ListView.builder(
                          itemCount: tasks.length,
                          itemBuilder: (context, index) {
                            return TaskTile(
                              taskTitle: tasks[index]["todo"],
                            );
                          },
                        );
                      }
                    }),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return const AddTask();
            },
          );
        },
        backgroundColor: Colors.blueAccent[400],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
