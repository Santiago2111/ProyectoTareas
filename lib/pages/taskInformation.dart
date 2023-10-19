import 'package:flutter/material.dart';
import 'package:tareas/data/TaskData.dart';
import 'package:tareas/main.dart';

class taskInformation extends StatelessWidget {
  final TaskData? ud;

  const taskInformation({Key? key, this.ud}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    tasks.sort((a, b) {
      int prioridadA = orderPriority(a.priority.toString());
      int prioridadB = orderPriority(b.priority.toString());

      if(prioridadA != prioridadB){
        return prioridadA.compareTo(prioridadB);
      }else{
        return a.date.toString().compareTo(b.date.toString());
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: Text("Information"),
        backgroundColor: Color.fromARGB(136, 21, 248, 40),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text("Title: " + tasks[index].title.toString()),
              subtitle: Text("Description: " + "${tasks[index].description.toString()} \nExpiredDate:  ${tasks[index].date} \nPriority: ${tasks[index].priority}"),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: (){
                  tasks.removeAt(index);
                  Navigator.popUntil(context, ModalRoute.withName('/'));
                  TitleController.text = "";
                  DescriptionController.text = "";
                  DateController.text = "";
                },
              ),
            );
          }
        )
      ),
      floatingActionButton: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Color.fromARGB(136, 21, 248, 40))
        ),
        child: Text("Exit"),
        onPressed: () {
          showAlert(context);
        },
      ),
    );
  }

  void showAlert(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Task Register"),
          content: Text("¿Are you sure you want to exit?"),
          actions: [
            TextButton(
              onPressed: () {
                TitleController.text = "";
                DescriptionController.text = "";
                DateController.text = "";
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
              child: Text("Yes"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("No"),
            ),
          ],
        );
      },
    );
  }
}

int orderPriority(String priority) {
  if (priority == 'High') {
    return 0;
  } else if (priority == 'Medium') {
    return 1;
  } else if (priority == 'Low') {
    return 2;
  } else {
    return 3; 
  }
}