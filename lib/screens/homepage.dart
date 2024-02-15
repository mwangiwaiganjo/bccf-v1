import 'package:bccf/components/navigater.dart';
import 'package:bccf/components/notification.dart';
import 'package:bccf/components/word.dart';
import 'package:bccf/main.dart';
import 'package:bccf/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String greatings() {
    final current = DateTime.now();
    final _hour = current.hour;
    if (_hour < 12) {
      return "Good Morning,";
    } else if (_hour < 18) {
      return "Good Afternoon,";
    } else {
      return "Good Evening,";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.grey.shade300,
        backgroundColor: Colors.grey.shade200,
        toolbarHeight: 70,
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(45),
          ),
        ),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 40,
              child: Image(image: AssetImage("assets/logo.jpeg")),
            ),
            Text(
              "The BCCF APP",
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 19,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
        actions: [
          Row(
            children: [
              NotificationIcon(icon: Icons.notifications, counter: 5),
              SizedBox(width:10),
              Padding(
                padding: const EdgeInsets.only(top:22),
                child: Column(
                  children: [
                    Icon(Icons.person,
                    color: Colors.black,
                    size: 25,),
                    Text('User',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400,
                      fontSize: 14
                    ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10,),
              Padding(
                padding: const EdgeInsets.only(top:22),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        try{
                          await supabase.auth.signOut();
                        } on AuthException catch(e){
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("${e.message}"))
                          );
                        }
                        catch(e){
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("${e}"))
                          );
                        }

                        // Navigator.of(context).push(MaterialPageRoute(builder: (_)=>LoginScreen()));
                        print("logged out");
                      },
                      child: Icon(
                        Icons.logout_rounded,
                      color: Colors.black,
                      size: 25,),
                    ),
                    Text('Logout',
                    style:GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight:FontWeight.w400 
                    ),
                    ),
                  ],
                ),
              ),
              SizedBox( width: 10,)
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const SizedBox(height: 20),
            Word(),
            const SizedBox(height: 30),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                 children: [
                  Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Navigatetab(logo: Image.asset("assets/Church.jpg"), name: "Services"),
                Navigatetab(logo: Image.asset("assets/calender.png"), name: "Events"),
                Navigatetab(logo: Image.asset("assets/Giving.jpg"), name: "Offering"),
              ],
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Navigatetab(logo: Image.asset("assets/Prayer.jpg"), name: "Prayer Request"),
                Navigatetab(logo: Image.asset("assets/Projects.jpg"), name: "Projects"),
                Navigatetab(logo: Image.asset("assets/Social.png"), name: "Our Socials"),

                 ],
            )
                 ]
              ),
            ),
          ],
        ),
      ),
    );
  }
}
