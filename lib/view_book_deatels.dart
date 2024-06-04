import 'package:flutter/material.dart';
class BookDetails extends StatelessWidget {
  BookDetails({super.key ,required this.image,required this.title,required this.subtitle,required this.isbn13});
  String? image;
  String? title;
  String ? subtitle;
  String ?isbn13;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:
        Wrap(
          alignment: WrapAlignment.center,
          children: [
            SizedBox(height: 100,),
            CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: NetworkImage("${image}"),
              radius: 150,
            ),
            Text("${title}",style: TextStyle(fontSize: 12,fontWeight:FontWeight.bold )),
            Text("${subtitle}",style: TextStyle(fontSize: 12,fontWeight:FontWeight.bold )),
            Text("${isbn13}",style: TextStyle(fontSize: 12,fontWeight:FontWeight.bold )),



          ],
        ),
      ),
    );
  }
}