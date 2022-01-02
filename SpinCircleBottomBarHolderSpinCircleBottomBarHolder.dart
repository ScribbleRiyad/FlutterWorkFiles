 SpinCircleBottomBarHolder(
        bottomNavigationBar: SCBottomBarDetails(
            circleColors: [Colors.white, Colors.orange, Colors.redAccent],
            iconTheme: const IconThemeData(color: Colors.black45),
            activeIconTheme: const IconThemeData(color: Colors.orange),
            backgroundColor: Colors.white,
            titleStyle: const TextStyle(color: Colors.black45, fontSize: 12),
            activeTitleStyle: const TextStyle(
                color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
            actionButtonDetails: SCActionButtonDetails(
                color: Colors.redAccent,
                icon: const Icon(
                  Icons.expand_less,
                  color: Colors.white,
                ),
                elevation: 2),
            elevation: 2.0,
            items: [
              // Suggested count : 4
              SCBottomBarItem(
                  icon: Icons.verified_user, title: "User", onPressed: () {}),
              SCBottomBarItem(
                  icon: Icons.supervised_user_circle,
                  title: "Details",
                  onPressed: () {}),
              SCBottomBarItem(
                  icon: Icons.notifications,
                  title: "Notifications",
                  onPressed: () {}),
              SCBottomBarItem(
                  icon: Icons.details, title: "New Data", onPressed: () {}),
            ],
            circleItems: [
              //Suggested Count: 3
              SCItem(icon: const Icon(Icons.delete), onPressed: () {}),
              SCItem(
                  icon: const Icon(Icons.add, semanticLabel: "Add Note",),
                  
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const AddnotePage()));
                  }),
              
              SCItem(icon: const Icon(Icons.update), onPressed: () {}),
            ],
            bnbHeight: 80 // Suggested Height 80
            ),
        child:  SizedBox(
            height: double.infinity,
             width: double.infinity,
             child: GridView.builder(
                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                     crossAxisCount: 2),
                 itemCount: 20,
                 itemBuilder: (BuildContext context, int i) => Card(
                        child: Center(
                       child: Text("Card Number $i"),
                     ))),
           ),
        ),