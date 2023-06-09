import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map data = {};

  @override
  Widget build(BuildContext context) {

    data = ModalRoute.of(context)?.settings.arguments as Map;
    print(data);
    //set background

    String? bgImage = data['isDaytime'] ? 'day.png' : 'night.png';
    Color bgColor = data['isDaytime'] ? Colors.blue : Colors.white12;


    return Scaffold(
      backgroundColor: bgColor,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/$bgImage'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
          child: SafeArea(
              child: Column(
                children: [
                  FlatButton.icon(
                      onPressed: () async {
                        dynamic result = await Navigator.pushNamed(context, '/location');
                        setState((){
                          data = {
                            'time' : result['time'],
                            'location' : result['location'],
                            'isDaytime' : result['isDaytime'],
                            // 'time' : result['time'],
                          };
                        });

                      },
                      icon: Icon(
                          Icons.edit_location,
                          color: Colors.grey[300],
                      ),
                      label: Text('Edit Location'),

                  ),
                  SizedBox(height: 20 ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        data['location'],
                        style: TextStyle(
                          fontSize: 28,
                          letterSpacing: 2,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                      data['time'],
                    style: TextStyle(
                      fontSize: 66,
                      letterSpacing: 2,
                    ),
                  ),
                ],
              )
          ),
        ),
      ),
    );
  }
}
