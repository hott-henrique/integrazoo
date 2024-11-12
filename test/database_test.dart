import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';

void main() {
  late Database database;
  
  // O método sqfliteFfiInit() inicializa o sqflite_common_ffi para que o banco de dados possa ser aberto corretamente no ambiente de testes. Essas duas linhas garantem que o sqflite usará a implementação baseada em FFI para abrir e manipular o banco de dados em vez da implementação nativa do Android/iOS, que não é compatível com os testes unitários.
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  /*
  setUp e tearDown são funções disponibilizadas pela própria biblioteca flutter_test. 

  setUp é executada sempre antes de qualquer teste. Como neste arquivo temos três testes, a função setUp será executada três vezes. Podemos colocar qualquer código dentro dela, geralmente ela é usada para gerenciar a entrada no banco de dados.
  
  tearDown é o contrário de setUp. É uma função executada após cada teste. Geralmente, ela é usada para limpar ou restaurar o ambiente de teste, fechando o banco de dados, por exemplo.
  */

  int counter = 0;
  setUp(() async {
    counter++;
    // Cria um banco de dados temporário para os testes. O banco de dados criado segue o mesmo padrão do banco que será utilizado no aplicativo real.
    final path = join(await getDatabasesPath(), 'test_database.db');
    database = await openDatabase(path, onCreate: (db, version) async {
      await db.execute("""
          CREATE TABLE IF NOT EXISTS Bovine(
            id INTEGER UNIQUE PRIMARY KEY,
            name TEXT,
            sex INTEGER /* 0: Male, 1: Female */
          );
        """);
      },
      version: 1,
    );
  });

  // Após rodar o teste, a tabela Bovine é limpa para não ocasionar em erros após a execução de novos testes.
  tearDown(() async {
    await database.execute("""DELETE FROM Bovine""");
  });

  // Essa função não mostra nenhum dado no terminal, ela retorna 1 caso o teste passe e -1 caso contrário.
  test('Insere um bovino e verifica se ele foi inserido no banco de dados', () async {
    final bovine = {
      'name': 'Bovino $counter',
      'sex': 0
    };
    await database.insert('Bovine', bovine);
    final List<Map<String, dynamic>> result = await database.query('Bovine');

    // De acordo com o que é colocado no 'expect' o teste retornará algo específico. Caso haja alguma informação que não seja coerente com os dados presentes no banco de dados o teste retornará um erro.
    expect(result.length, 0);
    expect(result[0]['name'], 'Bovino $counter');
  });
}
