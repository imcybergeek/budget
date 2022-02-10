import 'package:flutter/material.dart';

class NewCategory extends StatelessWidget {
  const NewCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Category"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.check),
            color: Colors.white,
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 20),
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(50)),
                  child: Icon(
                    Icons.done_all_sharp,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
                Flexible(
                  child: TextField(
                    maxLength: 15,
                    decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Category Name',
                        labelStyle:
                            TextStyle(color: Colors.grey, fontSize: 20)),
                  ),
                )
              ],
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Icon(
                  Icons.palette_outlined,
                  color: Colors.grey[400],
                  size: 40,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: MaterialButton(
                  onPressed: () {},
                  color: Colors.red,
                  height: 25,
                  minWidth: 100,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
