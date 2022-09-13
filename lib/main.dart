import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:untitled2/models/user.dart';
import 'package:untitled2/ui/ResponseScreen.dart';
import 'package:untitled2/utils/controller.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('user');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(7, 127, 123, 100),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(50)),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTsIlzGp1laQheiAAjrbJJ3pasHLjMBnIUEZg&usqp=CAU'))),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Welcome',
                                  style: GoogleFonts.abel(
                                    textStyle: const TextStyle(
                                        color: Colors.grey, fontSize: 20),
                                  )),
                              Text('Sign In',
                                  style: GoogleFonts.abel(
                                    textStyle: const TextStyle(
                                        color: Colors.white, fontSize: 50),
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                        borderRadius: BorderRadius.only(topRight: Radius.circular(40), topLeft:  Radius.circular(40))
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(30),
                            child: Column(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    FittedBox(
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                            'Email',
                                          style: GoogleFonts.poppins(
                                            textStyle: const TextStyle(
                                              fontSize: 20,
                                            )
                                          ),
                                        ),
                                      ),
                                    ),
                                    TextField(
                                      controller: InputController.gmail,
                                      decoration: const InputDecoration(
                                        hintText: 'Urmail@gmail.com'
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 25,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    FittedBox(
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                            'Password',
                                          style: GoogleFonts.poppins(
                                            textStyle: const TextStyle(
                                              fontSize: 20,
                                            )
                                          ),
                                        ),
                                      ),
                                    ),
                                    TextField(
                                      controller: InputController.password,
                                      decoration: const InputDecoration(
                                        hintText: 'Enter password '
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 50,),
                                Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Forgot Password ?',
                                    style: GoogleFonts.roboto(
                                      textStyle: const TextStyle(
                                        color: Colors.grey
                                      )
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 30,),
                                Row(
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          if(InputController.gmail.text.isEmpty || InputController.password.text.isEmpty){
                                              AwesomeDialog(
                                                context: context,
                                                dialogType: DialogType.error,
                                                animType: AnimType.bottomSlide,
                                                title: 'Error !',
                                                desc: 'Error........................',
                                                btnCancelOnPress: () {},
                                                btnOkOnPress: () {},
                                              ).show();
                                          }else{
                                            var box = Hive.box('user');
                                            User user = User(gmail: InputController.gmail.text, password: InputController.password.text);
                                            box.put('user', {'gmail':user.gmail,'password':user.password});
                                            Navigator.push(context, MaterialPageRoute(builder: (context)=> const ResponseScreen()));
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15)
                                            )
                                          ),
                                          padding: const EdgeInsets.all(15),
                                          backgroundColor: const Color.fromRGBO(7, 127, 123, 100),
                                        ),
                                        child: const Text(
                                            'Sign In',
                                          style: TextStyle(
                                            fontSize: 20
                                          ),
                                        ),
                                  )),
                                ]),
                                const SizedBox(height: 30,),
                                Container(
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Text('Don\'t have an account ?'),
                                      Text('Sign Up',style: TextStyle(color: Colors.blue),)
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
              ),
            ),
          ],
        ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
