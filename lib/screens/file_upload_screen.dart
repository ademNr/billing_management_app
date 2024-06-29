import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:gestion_des_factures/screens/data_screen.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:permission_handler/permission_handler.dart';

class FileUploadScreen extends StatefulWidget {
  @override
  _FileUploadScreenState createState() => _FileUploadScreenState();
}

class _FileUploadScreenState extends State<FileUploadScreen> {
  PlatformFile? _selectedFile;
  bool isLoading = false;
  var date;
  var numero;
  var montantHT;
  var montantTVA;
  var montantTTC;
  final ImagePicker _picker = ImagePicker();
  Future<void> _checkPermission() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      await Permission.camera.request();
    }
  }

  Future<void> _pickFileFromCamera() async {
    _checkPermission();
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);

    if (photo != null) {
      setState(() {
        _selectedFile = PlatformFile(
          name: photo.name,
          path: photo.path,
          size: File(photo.path).lengthSync(),
        );
      });
    } else {
      // User canceled the picker
    }
  }

  Future<bool?> uploadFile() async {
    if (_selectedFile != null) {
      try {
        setState(() {
          isLoading = true;
        });
        var uri = Uri.parse('http://192.168.202.19:8000/image/');
        var request = http.MultipartRequest('POST', uri);
        request.files.add(
          await http.MultipartFile.fromPath(
            'image',
            _selectedFile!.path!,
          ),
        );

        var response = await request.send();
        var responseData = await response.stream.bytesToString();

        if (response.statusCode == 201) {
          var jsonResponse = jsonDecode(responseData);

// Example assuming jsonResponse structure matches your JSON format
          date = jsonResponse['json_summary']['Date'];
          numero = jsonResponse['json_summary']['Numero'];
          montantHT = jsonResponse['json_summary']['Montant HT'];
          montantTVA = jsonResponse['json_summary']['Montant TVA'];
          montantTTC = jsonResponse['json_summary']['Montant TTC'];

// Print or use the parsed values
          print(date.toString());
          print(numero.toString());
          print(montantHT.toString());
          print(montantTVA.toString());
          print(montantTTC.toString());
          print('File uploaded successfully');
          return true;
        } else {
          print('File upload failed');
          return false;
        }
      } catch (err) {
        print(err);
        return false;
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg', 'jpeg', 'pdf'],
      allowMultiple: false,
    );

    if (result != null) {
      setState(() {
        _selectedFile = result.files.first;
      });
    } else {
      // User canceled the picker
    }
  }

  Widget _buildFileDisplay() {
    if (_selectedFile == null) {
      return const SizedBox();
    } else if (_selectedFile!.extension == 'pdf') {
      return ListTile(
        leading: const Icon(Icons.insert_drive_file),
        title: Text(_selectedFile!.name),
        subtitle: Text('${_selectedFile!.size} bytes'),
      );
    } else if (_selectedFile!.extension == 'png' ||
        _selectedFile!.extension == 'jpg' ||
        _selectedFile!.extension == 'jpeg') {
      return InkWell(
        onTap: _pickFile,
        child: Image.file(
          File(_selectedFile!.path!),
          width: 500,
          height: 300,
          fit: BoxFit.fitHeight,
        ),
      );
    } else {
      return const Text("le type de fichier n'est pas pris en charge");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Gestion facture',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildFileDisplay(),
            const SizedBox(height: 10),
            _selectedFile != null
                ? const SizedBox()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Selectionnez une facture",
                        style: TextStyle(
                            color: Colors.black87, fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      InkWell(
                        onTap: _pickFile,
                        child: DottedBorder(
                          strokeWidth: 2,
                          color: Colors.blue,
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(12),
                          padding: const EdgeInsets.all(6),
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12)),
                            child: Container(
                              color: Colors.blue.withOpacity(0.8),
                              height: 200,
                              width: 300,
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.file_copy,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    "Selectionnez une facture",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Prenez une image",
                        style: TextStyle(
                            color: Colors.black87, fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      InkWell(
                        onTap: _pickFileFromCamera,
                        child: DottedBorder(
                          strokeWidth: 2,
                          color: Colors.blue,
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(12),
                          padding: const EdgeInsets.all(6),
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12)),
                            child: Container(
                              color: Colors.blue.withOpacity(0.8),
                              height: 200,
                              width: 300,
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.camera_alt_sharp,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    "prenez une image",
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
            const SizedBox(
              height: 10,
            ),
            _selectedFile == null
                ? const SizedBox()
                : isLoading
                    ? LoadingAnimationWidget.staggeredDotsWave(
                        size: 50,
                        color: Colors.blue,
                      )
                    : Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () async {
                            bool? test = await uploadFile();
                            if (test!) {
                              Get.to(() => DataScreen(), arguments: {
                                'numero': numero.toString(),
                                'date': date.toString(),
                                'montantHT': montantHT.toString(),
                                'montantTTC': montantTTC.toString(),
                                'montantTVA': montantTVA.toString()
                              });
                            }
                          },
                          child: const Text(
                            'envoyez la facture',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
          ],
        ),
      ),
    );
  }
}
