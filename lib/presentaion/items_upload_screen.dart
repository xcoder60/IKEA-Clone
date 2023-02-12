import 'dart:typed_data';

import 'package:ar_app/data/api_consumer.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ItemsUploadScreen extends StatefulWidget {
  @override
  State<ItemsUploadScreen> createState() => _ItemsUploadScreenState();
}

class _ItemsUploadScreenState extends State<ItemsUploadScreen> {
  Uint8List? imageFileUint8List;
  TextEditingController sellerNameTextEditingController =
      TextEditingController();
  TextEditingController sellerphoneTextEditingController =
      TextEditingController();
  TextEditingController itemNameTextEditingController = TextEditingController();
  TextEditingController itemDescriptionTextEditingController =
      TextEditingController();
  TextEditingController itemPriceTextEditingController =
      TextEditingController();

  bool isUploading = false;

  //Upload From Screen
  Widget UploadFromScreen() {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Upload New Item",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [Padding(
          padding: const EdgeInsets.all(4.0),
          child: IconButton(onPressed: (){}, icon: const Icon(Icons.cloud_upload,color: Colors.white,)),
        ),],
      ),
      body: ListView(
        children: [
          isUploading == true
              ? const LinearProgressIndicator(
                  color: Colors.purpleAccent,
                )
              : Container(),

          //image
          SizedBox(
            height: 230,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Center(
              child: imageFileUint8List != null
                  ? Image.memory(imageFileUint8List!)
                  : const Icon(
                      Icons.image_not_supported,
                      color: Colors.grey,
                      size: 50,
                    ),
            ),
          ),
          const Divider(
            color: Colors.white70,
            thickness: 2,
          ),

          //Seller NAme
          ListTile(
            leading: const Icon(
              Icons.person_pin_rounded,
              color: Colors.white,
            ),
            title: SizedBox(
              width: 250,
              child: TextField(
                style: const TextStyle(color: Colors.grey),
                controller: sellerNameTextEditingController,
                decoration: const InputDecoration(
                    hintText: "Seller Name",
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none),
              ),
            ),
          ),
          const Divider(
            color: Colors.white70,
            thickness: 2,
          ),

          //Seller Phone
          ListTile(
            leading: const Icon(
              Icons.phone_iphone_rounded,
              color: Colors.white,
            ),
            title: SizedBox(
              width: 250,
              child: TextField(
                style: const TextStyle(color: Colors.grey),
                controller: sellerphoneTextEditingController,
                decoration: const InputDecoration(
                    hintText: "Seller phone",
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none),
              ),
            ),
          ),
          const Divider(
            color: Colors.white70,
            thickness: 2,
          ),

          // item name
          ListTile(
            leading: const Icon(
              Icons.title_rounded,
              color: Colors.white,
            ),
            title: SizedBox(
              width: 250,
              child: TextField(
                style: const TextStyle(color: Colors.grey),
                controller: itemNameTextEditingController,
                decoration: const InputDecoration(
                    hintText: "Item Name",
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none),
              ),
            ),
          ),
          const Divider(
            color: Colors.white70,
            thickness: 2,
          ),

          //item Description
          ListTile(
            leading: const Icon(
              Icons.description,
              color: Colors.white,
            ),
            title: SizedBox(
              width: 250,
              child: TextField(
                style: const TextStyle(color: Colors.grey),
                controller: itemDescriptionTextEditingController,
                decoration: const InputDecoration(
                    hintText: "Item Description",
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none),
              ),
            ),
          ),
          const Divider(
            color: Colors.white70,
            thickness: 2,
          ),

          //item price
          ListTile(
            leading: const Icon(
              Icons.price_change,
              color: Colors.white,
            ),
            title: SizedBox(
              width: 250,
              child: TextField(
                style: const TextStyle(color: Colors.grey),
                controller: itemPriceTextEditingController,
                decoration: const InputDecoration(
                    hintText: "Item price",
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none),
              ),
            ),
          ),
          const Divider(
            color: Colors.white70,
            thickness: 2,
          ),
        ],
      ),
    );
  }

  // default screen

  Widget defaultscreen(){
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Upload New Item",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  [
            const Icon(
              Icons.add_photo_alternate,
              color: Colors.white,
              size: 200,
            ),
            ElevatedButton(onPressed:(){
              showDialogbox();
            },style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black54,
            ) , child:const Text("Add New Item",style: TextStyle(color: Colors.white),) )

          ],
        ),
      ),

    );
  }


  showDialogbox(){

    return showDialog(context: context, builder:(context){
      return  SimpleDialog(
        backgroundColor: Colors.black,
        title: const Text(
          "Item Image",
          style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,),
        ),
        children: [
          SimpleDialogOption(
            onPressed: (){
              Captureimagewithphonecamera();
            },
            child: const Text(
              "Capture Image With Camera",
              style: TextStyle(color: Colors.grey),
            ) ,
          ),
          SimpleDialogOption(
            onPressed: (){
              ChooseIamgeFromPHoneGallery();
            },
            child: const Text(
              "Choose Image From Gallery",
              style: TextStyle(color: Colors.grey),
            ) ,
          ),
          SimpleDialogOption(
            onPressed: (){
              Navigator.pop(context);
            },
            child: const Text(
              "Cancel",
              style: TextStyle(color: Colors.grey),
            ) ,
          ),
        ],

      );
    } );
  }

  Captureimagewithphonecamera() async
  {
    Navigator.pop(context);

    try{

      final pickedImage = await ImagePicker().pickImage(source: ImageSource.camera);

      if(pickedImage != null){

        String imagePath = pickedImage.path;
        imageFileUint8List = await pickedImage.readAsBytes();

        // Remove BackGround From Image
        
       imageFileUint8List = await ApiConsumer().RemoveBackgroundApi(imagePath);


        setState(() {
          imageFileUint8List;
        });
      }


    }
    catch(errorMsg){ 
      
      print(errorMsg.toString());

      setState(() {
        imageFileUint8List = null;
      });


    }

  }

  ChooseIamgeFromPHoneGallery() async
  {
    Navigator.pop(context);
    try{

      final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);

      if(pickedImage != null){

        String imagePath = pickedImage.path;
        imageFileUint8List = await pickedImage.readAsBytes();

        // Remove BackGround From Image

        imageFileUint8List = await ApiConsumer().RemoveBackgroundApi(imagePath);


        setState(() {
          imageFileUint8List;
        });
      }


    }
    catch(errorMsg){

      print(errorMsg.toString());

      setState(() {
        imageFileUint8List = null;
      });


    }


  }


  @override
  Widget build(BuildContext context) {
    return imageFileUint8List == null ? defaultscreen() : UploadFromScreen();
  }
}
