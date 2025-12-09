import 'package:app_bar_auto_hide/app_bar_auto_hide.dart';
import 'package:example/controller/todos_controller.dart';
import 'package:flutter/material.dart';
import 'package:get_x_master/get_x_master.dart';

class Home extends StatelessWidget {
  const Home({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarAutoHide(
        notifier: TodosController.to.notifier,
        title: Text('Todos', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          TodosController.to.notifier.value = notification;
          return true;
        },
        child: SizedBox(
          height: context.height,
          width: context.width,
          child: TodosController.to.todos.isEmpty
              ? const Center(child: Text('No todos'))
              : ListView.builder(
                  itemCount: TodosController.to.todos.length,
                  itemBuilder: (context, index) {
                    return Card(child: ListTile(title: Text('Todo $index')));
                  },
                ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.bottomSheetExpandable(
            initialChildSize: 0.5,
            minChildSize: 0.25,
            maxChildSize: 0.75,
            borderRadius: 20.0,
            isDismissible: true,
            enableDrag: true,
            startFromTop: true,
            isShowCloseBottom: true,
            itemPaddingTop: 50,
            builder: (context) {
              return LoginWidget();
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class LoginWidget extends StatelessWidget {
  const LoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      height: Get.height,
      //  color: Colors.white,
      child: Column(
        spacing: 15.0,
        children: [
          TextFormField(
            decoration: InputDecoration(
              labelText: "Title",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
          ),
          TextFormField(
            minLines: 4,
            maxLines: 5,
            decoration: InputDecoration(
              labelText: "Description",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
          ),
          MaterialButton(
            onPressed: () {
              Navigator.pop(context);
            },
            minWidth: context.width,
            color: Colors.deepPurpleAccent,
            height: 56,
            child: Text("Add", style: TextStyle(color: Colors.white)),
          ),
        ],
      ).paddingAll(15.0),
    );
  }
}
