import 'dart:io';
import 'package:az_health_care/features/onboarding_profile_setup/manager/sensor_upload_cubit/sensor_upload_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http_parser/http_parser.dart';

import 'package:az_health_care/core/network/end_points.dart';
import 'package:az_health_care/core/services/cache_helper.dart';
import 'package:az_health_care/shared/network/remote/dio_helper.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';

class SensorUploadCubit extends Cubit<SensorUploadState> {
  SensorUploadCubit() : super(SensorUploadInitialState());

  static SensorUploadCubit get(context) => BlocProvider.of(context);

  File? _selectedFile;
  String? _fileName;

  File? get selectedFile => _selectedFile;
  bool isFileUploaded = false;

  String? get fileName => _fileName;

  Future<void> selectJsonFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['json'],
      );

      if (result != null) {
        _selectedFile = File(result.files.single.path!);
        _fileName = result.files.single.name;
        emit(FileSelectedState(_selectedFile!, _fileName!));
      }
    } catch (e) {
      emit(SensorUploadErrorState('Failed to select file: ${e.toString()}'));
    }
  }

  Future<void> uploadSensorData() async {
    if (_selectedFile == null) {
      emit(SensorUploadErrorState('Please select a file first.'));
      return;
    }
    emit(SensorUploadLoadingState());
    var id = CacheHelper.getData(key: 'id');
    if (id == null) {
      emit(SensorUploadErrorState('Failed to Register please try Login.'));
    }
    try {
      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          _selectedFile!.path,
          filename: _fileName,
          contentType: MediaType('application', 'json'),
        ),
        'userId': id,
      });

      await DioHelper.postData(url: SENSOR_UPLOAD_FILE, data: formData);

      String fileContent = await _selectedFile!.readAsString();
      print('File: $_fileName');
      print('Content: $fileContent');
      isFileUploaded = true;
      emit(SensorUploadSuccessState());
    } catch (e) {
      print("============================");
      print('Error: ${e.toString()}');
      print("============================");
      emit(SensorUploadErrorState('Failed to upload file: ${e.toString()}'));
    }
    emit(FileSelectedState(_selectedFile!, _fileName!));
  }

  void reset() {
    _selectedFile = null;
    _fileName = null;
    emit(SensorClearState());
  }
}
