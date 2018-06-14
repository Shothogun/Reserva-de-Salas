FactoryBot.define do
    factory :user do
        email 'teste@teste.teste'
        username 'userteste'
        registration 'registroteste'
        course 'cursoteste'
        is_admin true
        password 'passwordteste'
    end
end