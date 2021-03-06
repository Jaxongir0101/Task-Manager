import 'package:flutter/material.dart';
import 'package:taskmanager/database_helper.dart';
import 'package:provider/provider.dart';
import '../../main_provider.dart';
import '../../models/task.dart';
import '../widgets/task_item.dart';
import 'thirdpage.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F5FF),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50))),
            backgroundColor: Colors.white,
            expandedHeight: MediaQuery.of(context).size.height * 0.3,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    )),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Icon(
                            Icons.arrow_back,
                            size: 24,
                            color: Color(0xFF324646),
                          ),
                          Icon(
                            Icons.search,
                            size: 24,
                            color: Color(0xFF324646),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Oct, ",
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                "2020",
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          addTaskButton()
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 0.0,
              child: Center(
                child: Text(' '),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25.0, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Tasks",
                          style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF2E3A59)),
                        ),
                       
                       
                        taskList()
                      ],
                    ));
              },
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }
void taskItemList(context){
    MainProvider mainProvider = Provider.of<MainProvider>(context, listen: false);
    mainProvider.updateTaskList();

  }
  Widget addTaskButton() {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ThirdPage(),
        )).then((value) => taskItemList(context));
      },
      child: Container(
        height: 40,
        width: 118,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomRight,
            stops: [0.0, 1.0],
            colors: [
              Color(0xFF9C2CF3),
              Color(0xFF3A49F9),
            ],
          ),
          color: Colors.deepPurple.shade300,
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Center(
            child: Text(
          "+ Add Task",
          style: TextStyle(color: Colors.white),
        )),
      ),
    );
  }

  Widget taskItem(Task task) {
    return Column(
      children: [
        SizedBox(
          height: 12,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(18)),
          child: ListTile(
            title: Text(
              task.title!,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text('2 Days ago'),
            trailing: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.more_vert,
              ),
            ),
            leading: Container(
              height: 61.0,
              width: 61.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Color(0xFF9C2CF3),
                      Color(0xFF3A49F9),
                    ],
                  )),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Image.asset(
                  'assets/images/list_icon.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

 Widget taskList() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .8,
      child: Consumer<MainProvider>(
        builder: (context, value, child) {
          return FutureBuilder(
            future: DatabaseHelper.intance.getTasks(),
            builder: ((context, AsyncSnapshot<List<Task>> snapshot) {
              return ListView.builder(
                padding: EdgeInsets.only(bottom: 10, right: 10),
                itemBuilder: (context, index) {
                  return TaskItem(snapshot.data![index]);
                },
                itemCount: snapshot.data?.length ?? 0,
              );
            }),
          );
       
        },
      ),
    );
  }


}
