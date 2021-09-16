final createTable = '''
CREATE TABLE character(
  id INTEGER NOT NULL PRIMARY KEY,
  nome VARCHAR(200),
  idade CHAR(20),
  raca CHAR(50),
  altura CHAR(50),
  genero CHAR(50),
  descricao VARCHAR(200),
  img BLOB
)
''';

