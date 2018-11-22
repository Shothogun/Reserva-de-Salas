#language: pt
#encoding: utf-8

Funcionalidade: criar_sala
  Como Administrador do Sistema
  Para que eu possa criar uma sala
  Eu quero poder ter um botão com opção de criar salas

  Cenario: Criar uma sala
  Dado que eu esteja cadastrado como "admin@admin.com", "123123", "Engenharia", "15/0115474", "admin" 
  E que esteja logado
  E que esteja na pagina "backoffice"
  E eu clicar no link "Adicionar Sala"
  Quando eu preencher o campo nome e localidade com:
  |room_name|BS-1234|
  |room_location|Babylon|
  E clicar no botao "Criar Sala"
  Então eu devo ver uma mensagem escrita "A sala foi criada com sucesso!"

  Cenario: Não criar uma sala
  Dado que eu esteja cadastrado como "admin@admin.com", "123123", "Engenharia", "15/0115474", "admin" 
  E que esteja logado
  E que esteja na pagina "backoffice"
  E eu clicar no link "Adicionar Sala"
  Quando eu preencher o campo nome e localidade com:
  |room_name|BS-1234|
  |room_location|Babylon|
  E clicar no botao "Criar Sala"
  Então eu devo ver uma mensagem escrita "A sala não pôde ser criada!"