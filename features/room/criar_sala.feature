#language: pt
#encoding: utf-8

Funcionalidade: criar_sala
  Como Administrador do Sistema
  Para que eu possa criar uma sala
  Eu quero poder ter um botão com opção de criar salas

Fundo: Começando da tela de adicionar uma sala, contida no backoffice de admin
  Dado que eu esteja cadastrado como "admin@admin.com", "123123", "Engenharia", "15/0115474", "admin"
  E que esteja logado
  E que esteja na pagina "backoffice"
  E eu clicar no link "Adicionar Sala"

Cenario: Criar uma sala
  Quando eu preencher o campo nome e localidade com:
  |Name|BS-1234|
  |Location|Ceubinho|
  E clicar no botao "Criar Sala"
  Então eu devo ver uma mensagem escrita "A sala foi criada com sucesso!"

Cenario: Não criar uma sala (Por já existir uma sala com o mesmo nome)
  Quando eu preencher o campo nome e localidade com:
  |Name|BS-1234|
  |Location|Ceubinho|
  E clicar no botao "Criar Sala"
  Então eu devo ver uma mensagem escrita "A sala não pôde ser criada!"

Cenario: Não criar uma sala (Por possuir o nome pequeno)
  Quando eu preencher o campo nome e localidade com:
  | Name     | BS |
  | Location | Ceubinho |
  E clicar no botao "Criar Sala"
  Então eu devo ver uma mensagem escrita "A sala não pôde ser criada!"

Cenario: Não criar uma sala (Por possuir o nome pequeno)
  Quando eu preencher o campo nome e localidade com:
  | Name     | BS |
  | Location | Ceubinho |
  E clicar no botao "Criar Sala"
  Então eu devo ver uma mensagem escrita "A sala não pôde ser criada!"

Cenario: Não criar uma sala (Por possuir o localizador pequeno)
  Quando eu preencher o campo nome e localidade com:
  | Name     | BS-123   |
  | Location | Ce |
  E clicar no botao "Criar Sala"
  Então eu devo ver uma mensagem escrita "A sala não pôde ser criada!"

Cenario: Não criar uma sala (Por possuir o nome grande)
  Quando eu preencher o campo nome e localidade com:
  | Name | BS-123-BN-123-BS-123-BN-123 |
  | Location | Ceubinho |
  E clicar no botao "Criar Sala"
  Então eu devo ver uma mensagem escrita "A sala não pôde ser criada!"

Cenario: Não criar uma sala (Por possuir o localizador grande)
  Quando eu preencher o campo nome e localidade com:
  | Name     | BS-123 |
  | Location | BSAN_BSAS_ICCN_ICCS_BIO_QUIM |
  E clicar no botao "Criar Sala"
  Então eu devo ver uma mensagem escrita "A sala não pôde ser criada!"