# This is the steps file referred to criar_sala feature
# Place your code relative to that feature here

Dado("que eu esteja cadastrado como {string}, {string}, {string}, {string}, {string}") do |email, password, course, registration, username|
  @user = User.create(username: username, password: password, 
  email: email, registration: registration, course: course, is_admin: true)
end

Dado("que esteja logado") do
  visit new_user_session_path
  fill_in :user_email, with: @user.email
  fill_in :user_password, with: @user.password
  click_button "Log in"
end

Dado("que esteja na pagina {string}") do |string|
  visit(backoffice_path)
end

Dado("eu clicar no link {string}") do |string|
  click_link "Cadastrar um novo admin"
end

Quando("eu preencher o formulário com:") do |table|
  # table is a Cucumber::MultilineArgument::DataTable
  table.rows_hash.each do |field, value|
    fill_in field, :with => value
  end
end

E("clicar no botão {string}") do |string|
  click_button("#{string}")
end

Entao("eu devo ser redirecionado para a pagina {string}") do |string|
  expect(current_path).to eq("/#{string}")
end