import 'dart:io';

abstract class SensorUploadState {}

class SensorUploadInitialState extends SensorUploadState {}

class SensorUploadLoadingState extends SensorUploadState {}

class FileSelectedState extends SensorUploadState {
  final File file;
  final String fileName;

  FileSelectedState(this.file, this.fileName);
}

class SensorUploadSuccessState extends SensorUploadState {}

class SensorUploadErrorState extends SensorUploadState {
  final String message;

  SensorUploadErrorState(this.message);
}
class SensorClearState extends SensorUploadState {}

