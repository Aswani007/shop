import 'package:flutter/material.dart';

class UserProductItem extends StatelessWidget {
  final String title;
  final String imageUrl;

  UserProductItem(this.title, this.imageUrl);

  @override
   Widget build(BuildContext context) {
    return ListTile(
      //tileColor: ,
      title: Text(title,style: TextStyle(color: Colors.black,),),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(
          imageUrl,
        ), //cannot use fit because it is just the object that does the fetching
      ),
      trailing: Container(
        width: 100.0,
        child: Row(
          children: <Widget>[
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.edit),
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.delete),
              color: Theme.of(context).errorColor,
            ),
          ],
        ),
      ),
    );
  }
}
