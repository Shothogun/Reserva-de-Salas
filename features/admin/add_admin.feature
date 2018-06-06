#language: pt
#encoding: utf-8

Funcionalidade: add_admin
  Como Administrador do Sistema
  Para que eu possa adicionar um administrador
  Eu quero poder ter um botão com opção adicionar um administrador

  Cenario: Adicionar um administrador
  Dado que eu esteja cadastrado como "admin@admin.com", "123123", "Engenharia", "15/0115474", "admin" 
  E que esteja logado
  E que esteja na pagina "backoffice"
  E eu clicar no link "Cadastrar um novo admin"
  Quando eu preencher o formulário com:
      | user_username | usuario1 			|
      | registration | password123 			|
      | course | password123 				|
      | email          | 150150296   		|
      | password | Ciência da Computação	|
      | password_confirmation |   a@a.com   |
      |e_admin 		| true 					|
  E clicar no botao "Sign Up"
  Então eu devo ser redirecionado para a página backoffice