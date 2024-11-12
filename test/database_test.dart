import 'package:flutter_test/flutter_test.dart';
import 'package:integrazoo/model/bovine/bovine.dart';
import 'package:integrazoo/persistence/bovine_persistence.dart';
import 'package:integrazoo/persistence/database_connector.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
// import 'package:path/path.dart';

void main() async {
  // Nos testes, não é possível criar diretamente uma conexão com o banco de dados do celular. Para testar as funções do banco, criamos um banco de dados em memória, que é momentâneo, serve apenas para rodar os comandos 'flutter test'.
  late Database database;
  
  // O método sqfliteFfiInit() inicializa o sqflite_common_ffi para que o banco de dados possa ser aberto corretamente no ambiente de testes. Essas duas linhas garantem que o sqflite usará a implementação baseada em FFI para abrir e manipular o banco de dados em vez da implementação nativa do Android/iOS, que não é compatível com os testes unitários.
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  /*
  setUp e tearDown são funções disponibilizadas pela própria biblioteca flutter_test. 

  setUp é executada sempre antes de qualquer teste. Como neste arquivo temos três testes, a função setUp será executada três vezes. Podemos colocar qualquer código dentro dela, geralmente ela é usada para gerenciar a entrada no banco de dados.
  
  tearDown é o contrário de setUp. É uma função executada após cada teste. Geralmente, ela é usada para limpar ou restaurar o ambiente de teste, fechando o banco de dados, por exemplo.
  */
  setUp(() async {
    database = await openDatabase(inMemoryDatabasePath);
    await BovinePersistence.onDatabaseCreate(database, 1);
    DatabaseConnector.db = database;
  });

  // Após rodar o teste, o database é fechado para não dar conflito com outros testes que podem vir a ser implementados.
  tearDown(() async {
    await database.close();
  });

  test('Deve criar bovinos e ler a lista de bovinos', () async {
      // Cria bovinos
      await BovinePersistence.createBovine(Bovine(0, 'Bovino teste', Sex.male));
      await BovinePersistence.createBovine(Bovine(1, 'Bovino teste', Sex.female));
      await BovinePersistence.createBovine(Bovine(2, 'Bovino teste', Sex.male));
      
      // Lê o rebanho
      final herd = await BovinePersistence.readHerd();
      print('===== Bovinos no Banco de Dados =====');
      for (var bovine in herd) {
        print('ID: ${bovine.id}, Name: ${bovine.name}, Sex: ${bovine.sex == Sex.male ? 'Male' : 'Female'}');
      }
    });
}
