import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagramapp/Views/widget_HomePage.dart';
import 'package:instagramapp/Views/widget_Progress.dart';
import 'package:instagramapp/Model/model_user.dart';

class Post extends StatefulWidget 
{
  final String postId;
  final String ownerId;
  //final String timeStamp;
  final dynamic likes;
  final String username;
  final String url;
  final String location;
  final String description;
 
 Post
 ({
     this.postId,
     this.ownerId,
     //this.timeStamp,
     this.likes,
     this.username,
     this.url,
     this.location,
     this.description
  });

factory Post.fromDocument(DocumentSnapshot documentSnapshot)
{
  return Post
  (
    postId: documentSnapshot['postId'],
    ownerId: documentSnapshot['ownerId'],
    //timeStamp: documentSnapshot['timeStamp'],
    likes: documentSnapshot['likes'],
    username: documentSnapshot['username'],
    url: documentSnapshot['url'],
    location: documentSnapshot['location'],
    description: documentSnapshot['description'],
  );
}

 int getTotalNumberOfLikes(likes)
 {
    if(likes==null)
    {
      return 0;
    }

    int counter =0;
    likes.values.forEach((eachValue)
    {
      if(eachValue == true)
      {
        counter = counter + 1;
      }
    });
    return counter;
 }

  @override
  _PostState createState() => _PostState
  (
    postId: this.postId,
    ownerId: this.ownerId,
    likes: this.likes,
    username: this.username,
    url: this.url,
    location: this.location,
    description: this.description,
    likeCount: this.getTotalNumberOfLikes(this.likes)
  );
}

class _PostState extends State<Post> {

  final String postId;
  final String ownerId;
  Map likes;
  final String username;
  final String url;
  final String location;
  final String description;
  int likeCount;
  bool isLiked;
  bool showHeart = false;
  final String currentOnlineUserId = currentUser?.id;

 _PostState
 ({
     this.postId,
     this.ownerId,
     this.likes,
     this.username,
     this.url,
     this.location,
     this.description,
     this.likeCount
  });


  @override
  Widget build(BuildContext context) {

    isLiked  = (likes[currentOnlineUserId] == true);

    return Padding
    (
      padding: EdgeInsets.only(bottom:12.0),
      child: Column
      (
        mainAxisSize: MainAxisSize.min,
        children: <Widget>
        [
          createPostHead(),
          createPostPicture(),
          createPostFooter()
        ],
      ),
    );
  }

   createPostHead()
   {
     return FutureBuilder
     (
       future: userReference.document(ownerId).get(),
       builder: (context,dataSnapshot)
       {
           if(!dataSnapshot.hasData)
           {
             return circularProgress();
           }

           User user = User.fromDocument(dataSnapshot.data);
           bool isPostOwner = currentOnlineUserId == ownerId;
           return ListTile
           (
             leading: CircleAvatar(backgroundImage: NetworkImage(user.url),backgroundColor: Colors.grey,),
             title: GestureDetector
             (
               onTap:()=> print('show Profile'),
               child: Text
               (
                 user.username,
                 style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold),
               ),
             ),
             subtitle: Text(location,style: TextStyle(color:Colors.black),),
             trailing: isPostOwner ? 
                       IconButton
                       (
                         icon:Icon(Icons.more_vert,color:Colors.black), 
                         onPressed:()=>Text('post is deleted')
                       ) : Text(''),
           );
       }
     );
   }

  removeLike()
  {
    bool isNotPostOwner = currentOnlineUserId != ownerId;

    if(isNotPostOwner)
    {
      activityFeedReference.document(ownerId).collection('feedItems').document(postId).get()
                                                                                      .then
                                                                                      (
                                                                                        (document)
                                                                                        {
                                                                                          if(document.exists)
                                                                                          {
                                                                                            document.reference.delete();
                                                                                          }
                                                                                        }
                                                                                      );
    }
  }

  addLike()
  {
    bool isNotPostOwner = currentOnlineUserId != ownerId;
    
    if(isNotPostOwner)
    {
      activityFeedReference.document(ownerId).collection('feedItems').document(postId).setData
                                                                                       ({
                                                                                         'type' : 'Like',
                                                                                         'username':currentUser.username,
                                                                                         'userId': currentUser.id,
                                                                                         'timeStamp': timeStamp,
                                                                                         'url' : url,
                                                                                         'postId': postId,
                                                                                         'userProfileImg':currentUser.url
                                                                                       });
    }

  }

  controlUserLikePost()
  {
    bool _liked = likes[currentOnlineUserId] == true;

    if(_liked)
    {
      postReference.document(ownerId).collection('usersPosts').document(postId)
                                                              .updateData({"likes.$currentOnlineUserId":false});
      removeLike();

      setState(() 
      {
        likeCount = likeCount -1; 
        isLiked = false;
        likes[currentOnlineUserId] = false;
      });
    }

    else if(!_liked)
    {
      postReference.document(ownerId).collection('usersPosts').document(postId)
                                                              .updateData({"likes.$currentOnlineUserId":true});
      addLike();

      setState(() 
      {
        likeCount = likeCount + 1; 
        isLiked = true;
        likes[currentOnlineUserId] = true;
        showHeart = true;
      });
       Timer(Duration(milliseconds: 800),()
       {
           setState(() 
           {
             showHeart = false;  
           });
       });
    }
  }


   createPostPicture()
   {
     return GestureDetector
     (
       onDoubleTap: () => controlUserLikePost(),
       child: Stack
       (
         alignment: Alignment.center,
         children: <Widget>
         [
           //CachedNetworkImage(imageUrl: url)
           Image.network(url),
           showHeart ? Icon(Icons.favorite,size: 120.0,color: Colors.pink,):Text(""),
         ],
       ),
     );
   }
   createPostFooter()
   {
     return Column
     (
       children: <Widget>
       [
         Row
         (
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>
            [
              Padding(padding: EdgeInsets.only(top:40.0,left:20.0)),
              GestureDetector
              (
                onTap: () => controlUserLikePost(),
                child: Icon
                (
                  
                  isLiked ? Icons.favorite:Icons.favorite_border,
                  size: 28.0,
                  color: Colors.pink, 
                ),
               ),
               GestureDetector
               (
                 onTap: ()=>print('Show Comment'),
                 child: Icon
                 (
                   Icons.chat_bubble_outline,
                   size: 28.0,
                   color: Colors.pink,
                 ),
               )
            ],
         ),
         Row
         (
           children: <Widget>
           [
             Container
             (
               margin: EdgeInsets.only(left:20.0),
               child: Text
               (
                 "$likeCount likes",
                 style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold),
               ),
             )
           ],
         ),
         Row
         (
           crossAxisAlignment: CrossAxisAlignment.start,
           children: <Widget>
           [
             Container
             (
               margin: EdgeInsets.only(left:20.0),
               child: Text
               (
                 '$username',
                  style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold),
               ),
             ),
             Expanded
             (
               child: Text(description,style:TextStyle(color:Colors.white))
             )
           ],
         )
       ],
     );
   }
}