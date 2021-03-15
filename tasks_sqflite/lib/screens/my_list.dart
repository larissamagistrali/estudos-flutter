import 'package:flutter/material.dart';
import 'package:flutter_tasks/database/dao/task_dao.dart';
import 'package:flutter_tasks/models/task.dart';
import 'package:uuid/uuid.dart';

class MyList extends StatefulWidget {
  const MyList({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyListState createState() => _MyListState();
}

class _MyListState extends State<MyList> {
  final TaskDao _dao = TaskDao();
  final uuid = const Uuid();

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<List<Task>>>(
        initialData: [[], []],
        future: _loadTasks(),
        builder: (contex, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final pendentTasks = snapshot.data[0];
            final doneTasks = snapshot.data[1];
            return Column(
              children: <Widget>[
                const SizedBox(height: 50.0),
                const Padding(
                  padding: EdgeInsets.only(right: 60.0),
                  child: Text(
                    "Minhas tarefas",
                    style: TextStyle(
                      fontSize: 32.0,
                      fontFamily: 'Product Sans',
                    ),
                  ),
                ),
                if (pendentTasks.isEmpty && doneTasks.isEmpty)
                  Expanded(
                    child: Container(),
                  )
                else
                  Container(),
                if (pendentTasks.isEmpty && doneTasks.isEmpty)
                  Flex(
                    direction: Axis.vertical,
                    children: <Widget>[
                      Image.asset(
                        "assets/picture.png",
                        width: 250.0,
                        height: 250.0,
                      ),
                      const Text(
                        "Nenhuma tarefa ainda",
                        style: TextStyle(
                          fontFamily: 'Product Sans',
                          fontSize: 18.0,
                          letterSpacing: -0.4,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        "Vamos começar?",
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ],
                  )
                else
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: ListView(
                            children: pendentTasks
                                .map(
                                  (task) => Dismissible(
                                    key: Key(task.id.toString()),
                                    onDismissed: (direction) {
                                      setState(() {
                                        _dao.updateToDone(task.id);
                                      });
                                    },
                                    direction: DismissDirection.startToEnd,
                                    background: Container(
                                        color: Theme.of(context).accentColor),
                                    child: Column(
                                      children: <Widget>[
                                        ListTile(
                                          leading: const Icon(
                                              Icons.radio_button_unchecked),
                                          title: Text(task.description),
                                        ),
                                        const Divider(height: 1.0)
                                      ],
                                    ),
                                  ),
                                )
                                .toList()
                                  ..addAll(
                                    doneTasks.isEmpty
                                        ? []
                                        : [
                                            Dismissible(
                                              direction:
                                                  DismissDirection.startToEnd,
                                              background:
                                                  Container(color: Colors.red),
                                              key: const Key("Concluidas"),
                                              onDismissed: (direction) {
                                                setState(() {
                                                  // did = [];
                                                });
                                              },
                                              child: ExpansionTile(
                                                title: Text(
                                                  "Concluídas (${doneTasks.length})",
                                                  style: const TextStyle(
                                                    fontFamily: 'Product Sans',
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                children: doneTasks
                                                    .map(
                                                      (doneTask) => ListTile(
                                                        title: Text(doneTask
                                                            .description),
                                                        leading: const Icon(Icons
                                                            .check_circle_outline),
                                                      ),
                                                    )
                                                    .toList(),
                                              ),
                                            ),
                                          ],
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                if (pendentTasks.isEmpty && doneTasks.isEmpty)
                  Expanded(child: Container())
                else
                  Container()
              ],
            );
          }
          return Text('Loading');
        },
      ),
      floatingActionButton: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Theme.of(context).accentColor,
          elevation: 6.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        onPressed: () {
          buildNewSheet();
        },
        child: DefaultTextStyle(
          style: const TextStyle(color: Colors.white),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                ),
                const Text(
                  "Adicionar uma nova tarefa",
                  style: TextStyle(
                    fontFamily: 'Product Sans',
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: SizedBox(
        height: 55.0 + MediaQuery.of(context).padding.bottom,
        child: Material(
          color: Colors.white,
          elevation: 8.0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.menu, color: Colors.grey[700]),
                  onPressed: () {
                    buildNavigationSheet();
                  },
                ),
                IconButton(
                  icon: Icon(Icons.more_vert, color: Colors.grey[700]),
                  onPressed: () {
                    buildOptionSheet();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<List<List<Task>>> _loadTasks() async {
    final pendentTasks = await _dao.findAllPendent();
    final doneTasks = await _dao.findAllDone();
    return [pendentTasks, doneTasks];
  }

  void buildOptionSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        children: <Widget>[
          Expanded(child: Container()),
          Material(
            color: Colors.white,
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(6.0)),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, top: 25.0, bottom: 10.0),
                      child: Text(
                        "Ordenar por",
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey[800],
                        ),
                      ),
                    ),
                    const ListTile(
                      trailing: Icon(Icons.check),
                      title: Padding(
                        padding: EdgeInsets.only(left: 12.0),
                        child: Text(
                          "Tarefa",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const ListTile(
                      title: Padding(
                        padding: EdgeInsets.only(left: 12.0),
                        child: Text(
                          "Data",
                          style: TextStyle(),
                        ),
                      ),
                    ),
                    const Divider(),
                    Flex(
                      direction: Axis.vertical,
                      children: <Widget>[
                        const ListTile(
                          title: Text(
                            "Renomear lista",
                            style: TextStyle(fontSize: 15.0),
                          ),
                        ),
                        const ListTile(
                          title: Text(
                            "Apagar lista",
                            style:
                                TextStyle(fontSize: 15.0, color: Colors.grey),
                          ),
                        ),
                        ListTile(
                          onTap: null //did.isEmpty
                              ? null
                              : () {
                                  setState(() {
                                    // did = [];
                                    // Navigator.of(context).pop();
                                  });
                                },
                          title: Text(
                            "Exclua todas as tarefas concluídas",
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors
                                  .grey, //did.isEmpty ? Colors.grey : Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void buildNewSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        children: <Widget>[
          Expanded(child: Container()),
          Material(
            color: Colors.white,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(6.0),
            ),
            child: Column(
              children: <Widget>[
                TextField(
                  controller: controller,
                  autofocus: true,
                  style: const TextStyle(
                    fontFamily: 'Product Sans',
                    color: Colors.black,
                    fontSize: 18.0,
                  ),
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(
                      top: 20.0,
                      left: 24.0,
                      right: 24.0,
                      bottom: 12.0,
                    ),
                    border: InputBorder.none,
                    hintText: "Nova tarefa",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 10.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.add_circle,
                          color: Theme.of(context).accentColor,
                        ),
                        onPressed: () {},
                      ),
                      TextButton(
                        // splashColor: Colors.transparent,
                        // highlightColor: Colors.blue[600].withOpacity(0.17),
                        // shape: RoundedRectangleBorder(
                        //   borderRadius: BorderRadius.circular(5.0),
                        // ),
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            final Task newTask = Task(0, controller.text, 'N');
                            _dao.save(newTask);
                            //.then((id) => Navigator.pop(context));
                            //todo.add(controller.text);
                            controller.clear();
                          });
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "Salvar",
                          style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontFamily: 'Product Sans',
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void buildNavigationSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        children: <Widget>[
          Expanded(child: Container()),
          Material(
            color: Colors.white,
            child: SafeArea(
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 8.0),
                  ListTile(
                    leading: const CircleAvatar(
                      radius: 24.0,
                      child: Text(
                        "MF",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          "Maurício Freitas",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Product Sans',
                            fontSize: 14.0,
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "maurisf@gmail.com",
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 14.0,
                              ),
                            ),
                            const Icon(Icons.keyboard_arrow_down)
                          ],
                        )
                      ],
                    ),
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20.0,
                      top: 10.0,
                      bottom: 10.0,
                    ),
                    child: Container(
                      height: 48.0,
                      decoration: BoxDecoration(
                        color: Theme.of(context).accentColor.withOpacity(0.2),
                        borderRadius: const BorderRadius.horizontal(
                          left: Radius.circular(30.0),
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Text(
                            "Minhas tarefas",
                            style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Divider(),
                  const ListTile(
                      leading: Icon(Icons.add),
                      title: Text("Criar nova lista")),
                  const Divider(),
                  const ListTile(
                    leading: Icon(Icons.feedback),
                    title: Text("Ajuda e feedback"),
                  ),
                  const Divider(),
                  const ListTile(title: Text("Licenças de código aberto")),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12.0, top: 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        Text("Proteção de dados"),
                        SizedBox(width: 8.0),
                        Icon(
                          Icons.brightness_1,
                          size: 2.0,
                        ),
                        SizedBox(width: 8.0),
                        Text("Termos de uso")
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
