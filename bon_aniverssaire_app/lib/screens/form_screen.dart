import 'package:flutter/material.dart';
import 'package:bon_aniverssaire_app/data/contacts_inherited.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

File? sharedFile;

class FormScreen extends StatefulWidget {
  const FormScreen({Key? key, required this.contactsContext}) : super(key: key);

  final BuildContext contactsContext;

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController birthdayController = TextEditingController();
  TextEditingController imageController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  ImagePicker imagePicker = ImagePicker();
  File? imageSelected;


  bool valueValidator(String? value) {
    if (value != null && value.isEmpty) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Novo Contato'),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              height: 650,
              width: 375,
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(10),
                //border: Border.all(width: 1),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 128,
                      height: 128,
                      child: Column(
                        //coluna do botao de adc foto
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 100,
                            height: 100,
                            child: FloatingActionButton(
                              heroTag: null,
                              onPressed: pickImage,
                              child: const Icon(
                                Icons.add_photo_alternate_outlined,
                                size: 50,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: pickImage,
                            child: const Text(
                              'Adicionar foto',
                              style: TextStyle(
                                  decoration: TextDecoration.none,
                                  color: Colors.blueAccent),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      imageSelected == null
                          ? Container()
                          : SizedBox(
                              width: 200,
                              height: 200,
                              child: Image.file(imageSelected!)),
                    ],
                  ),
                  Padding( //NOME
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (String? value) {
                        if (valueValidator(value)) {
                          return 'Insira o nome do Aniversariante.';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.name,
                      controller: nameController,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Nome',
                        fillColor: Colors.white70,
                        filled: true,
                      ),
                    ),
                  ),  //Name Padding
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (value) {
                        if (valueValidator(value)) {
                          return 'Insira uma data válida';
                        }
                      },
                      keyboardType: TextInputType.datetime,
                      controller: birthdayController,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Data de aniversário',
                        fillColor: Colors.white70,
                        filled: true,
                      ),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ContactsInherited.of(widget.contactsContext)
                              .newContact(
                                  nameController.text,
                                  birthdayController.text,
                                  imageController.text);
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Adicionando contato...')));
                          Navigator.pop(context);
                        }
                      },
                      child: const Text('Adicionar')),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  pickImage() async {
    final PickedFile? temporaryImage =
        await imagePicker.getImage(source: ImageSource.gallery);
    if (temporaryImage != null) {
      setState(() {
        imageSelected = File(temporaryImage.path);
        sharedFile = File(temporaryImage.path);
      });
    }
  }



}
