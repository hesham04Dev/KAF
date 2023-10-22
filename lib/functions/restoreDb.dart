import 'dart:io';

import 'package:path_provider/path_provider.dart';

final _supportDir = getApplicationSupportDirectory();
final _tempDir = getTemporaryDirectory();

Future<void> localRestoreDbIfRestoreButtonClicked() async {
  final supportDir = await _supportDir;
  File needToRestoreOldDb = File(supportDir.path + "/default.restore");
  File restoredDb = File(supportDir.path + "/restored.isar");
  if (await restoredDb.exists()) {
    await _localRestoreNewDb(restoredDb);
  } else if (await needToRestoreOldDb.exists()) {
    await _localRestoreOldDb();
    needToRestoreOldDb.delete();
    /*This part done in the code but still not active since tell now we dont add
       * the code that will create the default.restore file */
  }
}

Future<void> _localRestoreNewDb(File restoredDb) async {
  final supportDir = await _supportDir;
  final temp = await _tempDir;

  File oldDb = File(supportDir.path + "\\default.isar");
  await oldDb.copy(temp.path + "\\default.isar");
  await oldDb.delete();

  restoredDb.rename(supportDir.path + "\\default.isar");
}

Future<void> _localRestoreOldDb() async {
  final temp = await _tempDir;
  final supportDir = await _supportDir;

  File db = File(supportDir.path + "/default.isar");
  await db.delete();

  final oldDb = File(temp.path + "/default.isar");
  await oldDb.copy(supportDir.path + "/default.isar");
}