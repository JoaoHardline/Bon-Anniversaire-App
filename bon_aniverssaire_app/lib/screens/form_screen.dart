import 'package:flutter/material.dart';
import 'dart:io';
import 'package:bon_aniverssaire_app/components/contato.dart';
import 'package:bon_aniverssaire_app/data/contact_dao.dart';
import 'package:bon_aniverssaire_app/data/contact_inherited.dart';
import 'package:image_picker/image_picker.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({Key? key, required this.contactContext}) : super(key: key);

  final BuildContext contactContext;

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController difficultyController = TextEditingController();

  //TextEditingController imageController = TextEditingController();

  File? _selectedImage = null; // armazena o arquivo da imagem selecionada.
  final _formKey = GlobalKey<FormState>();

  bool valueValidator(String? value) {
    if (value != null && value.isEmpty) {
      return true;
    }
    return false;
  }

  bool difficultyValidator(String? value) {
    if (value != null && value.isEmpty) {
      if (int.parse(value) > 5 || int.parse(value) < 1) {
        return true;
      }
    }
    return false;
  }

  DateTime _dateTime = DateTime.now();
  Duration? difference;
  DateTime currentDate = DateTime.now(); //apenas inicializando a variavel
  DateTime nextBirthday = DateTime.now(); //apenas inicializando a variavel

  void _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1899),
            lastDate: DateTime.now())
        .then((value) {
      setState(() {
        _dateTime = value!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          title: const Text('Novo Aniversariante'),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              height: 650,
              width: 375,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 200,
                    width: 144,
                    decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 2, color: Colors.transparent),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: _selectedImage != null
                          ? Image.file(_selectedImage!, fit: BoxFit.cover)
                          : Container(
                              child: Icon(
                              Icons.account_box_rounded,
                              size: 96,
                            )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: ElevatedButton(
                        onPressed: _pickImageFromGallery,
                        child: Text('Selecionar foto do aniversariante')),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    //TEXTO DO NOME
                    child: TextFormField(
                      validator: (String? value) {
                        if (valueValidator(value)) {
                          return 'Insira o nome do Aniversariante';
                        }
                        return null;
                      },
                      controller: nameController,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        //border: OutlineInputBorder(),
                        hintText: 'Nome',
                        fillColor: Colors.white70,
                        filled: true,
                      ),
                    ),
                  ),
                  Padding(
                    //PADDING DA DATA
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        //display chosen data
                        Text(
                          _dateTime != null
                              ? '${_dateTime.day.toString()} / ${_dateTime.month.toString()} / ${_dateTime.year.toString()}'
                              : 'Data não selecionada',
                          style: TextStyle(fontSize: 20),
                        ),

                        //button
                        ElevatedButton(
                          onPressed: _showDatePicker,
                          child: const Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Text(
                              'Alterar data de nascimento',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        nextBirthday = DateTime(currentDate.year, _dateTime.month, _dateTime.day);
                        difference = DateTime.now().difference(nextBirthday).abs();
                        setState(() {
                          ContactDao().save(Contact(nameController.text, imagem,
                              difference!.inDays + 1));
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'Aniversariante adicionado! atualize a página.'),
                          ),
                        );
                        Navigator.pop(context, true);
                      }
                    },
                    child: Text('Adicionar'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String imagem = '';

  Future _pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnedImage == null) return;
    setState(() {
      _selectedImage = File(returnedImage!.path);
      imagem = returnedImage.path;
    });
  }
}
