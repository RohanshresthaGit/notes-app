import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/core/common/widgets/app_bar.dart';
import 'package:notes_app/features/notes/widgets/notes_tile_component.dart';

class ViewNotesView extends StatefulWidget {
  const ViewNotesView({super.key});

  @override
  State<ViewNotesView> createState() => _ViewNotesViewState();
}

class _ViewNotesViewState extends State<ViewNotesView> {
  ValueNotifier<int> selectedIndex = ValueNotifier<int>(0);
  @override
  void dispose() {
    selectedIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          NotesAppBar(appBarTitle: 'Notes'),
          SliverPadding(
            padding: EdgeInsets.all(20),
            sliver: SliverList.separated(
              separatorBuilder: (context, index) => SizedBox(height: 15),
              itemCount: 10,
              itemBuilder: (context, index) {
                return NotesTileComponent(
                  title: "Notes & Assignments",
                  description:
                      "Complete notes and Assignments by 9 : 00 P.M and ",
                  createdAt: DateFormat('yyyy-MM-dd').format(DateTime.now()),
                );
              },
            ),
          ),
        ],
      ),
      // bottomNavigationBar: ValueListenableBuilder(
      //   valueListenable: selectedIndex,
      //   builder: (context, value, child) {
      //     return BottomNavigationBar(
      //       currentIndex: value,
      //       onTap: (index) {
      //         selectedIndex.value = index;
      //       },
      //       items: const [
      //         BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
      //         BottomNavigationBarItem(
      //           icon: Icon(Icons.search),
      //           label: "Search",
      //         ),
      //         BottomNavigationBarItem(
      //           icon: Icon(Icons.person),
      //           label: "Profile",
      //         ),
      //       ],
      //     );
      //   },
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/add'),
        child: Icon(Icons.add_outlined, size: 30),
      ),
    );
  }
}
