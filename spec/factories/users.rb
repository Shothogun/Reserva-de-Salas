FactoryBot.define do
  factory :user do
    email 'denis@email.com'
    username 'Denis Pimentinha'
    registration '150150296'
    course 'BCC'
    is_admin false
    password '123456'

  end

end