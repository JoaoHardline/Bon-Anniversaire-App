import 'package:bon_aniverssaire_app/components/contato.dart';
import 'package:bon_aniverssaire_app/data/database.dart';
import 'package:sqflite/sqflite.dart';

class ContactDao {
  static const String tableSql = 'CREATE TABLE $_tablename('
      '$_name TEXT, '
      '$_date INTEGER, '
      '$_image TEXT)';

  static const String _tablename = 'taskTable';
  static const String _name = 'name';
  static const String _date = 'date';
  static const String _image = 'image';

  save(Contact contato) async {
    print('Iniciando o save: ');
    final Database bancoDeDados = await getDatabase();
    var itemExists = await find(contato.nome);
    Map<String, dynamic> taskMap = toMap(contato);
    if (itemExists.isEmpty) {
      print('O contato não Existia.');
      return await bancoDeDados.insert(_tablename, taskMap);
    } else {
      print('O contato existia!');
      return await bancoDeDados.update(
        _tablename,
        taskMap,
        where: '$_name = ?',
        whereArgs: [contato.nome],
      );
    }
  }

  Map<String, dynamic> toMap(Contact contato) {
    print('Convertendo to Map: ');
    final Map<String, dynamic> mapaDeTarefas = Map();
    mapaDeTarefas[_name] = contato.nome;
    mapaDeTarefas[_date] = contato.data;
    mapaDeTarefas[_image] = contato.foto;
    print('Mapa de Tarefas: $mapaDeTarefas');
    return mapaDeTarefas;
  }

  Future<List<Contact>> findAll() async {
    print('Acessando o findAll: ');
    final Database bancoDeDados = await getDatabase();
    final List<Map<String, dynamic>> result =
        await bancoDeDados.query(_tablename);
    print('Procurando dados no banco de dados... encontrado: $result');
    return toList(result);
  }

  List<Contact> toList(List<Map<String, dynamic>> mapaDeContatos) {
    print('Convertendo to List:');
    final List<Contact> contatos = [];
    for (Map<String, dynamic> linha in mapaDeContatos) {
      final Contact contato = Contact(
        linha[_name],
        linha[_image],
        linha[_date],
      );
      contatos.add(contato);
    }
    print('Lista de Contatos: ${contatos.toString()}');
    return contatos;
  }

  Future<List<Contact>> find(String nomeDoContato) async {
    print('Acessando find: ');
    final Database bancoDeDados = await getDatabase();
    print('Procurando contato com o nome: ${nomeDoContato}');
    final List<Map<String, dynamic>> result = await bancoDeDados
        .query(_tablename, where: '$_name = ?', whereArgs: [nomeDoContato]);
    print('Tarefa encontrada: ${toList(result)}');

    return toList(result);
  }

  delete(String nomeDoContato) async {
    print('Deletando contato: $nomeDoContato');
    final Database bancoDeDados = await getDatabase();
    return await bancoDeDados.delete(
      _tablename,
      where: '$_name = ?',
      whereArgs: [nomeDoContato],
    );
  }
}
