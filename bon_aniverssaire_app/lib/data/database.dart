import 'package:bon_aniverssaire_app/data/contact_dao.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), 'contact.db');
  return openDatabase(path, onCreate: (db, version) {
    db.execute(ContactDao.tableSql);
  }, version: 1,);
}
