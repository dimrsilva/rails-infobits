# encoding: utf-8

Dado %r/^que existam (\d+) contatos cadastrados$/ do |page|
  15.times do
    Contact::Contact.create
  end
end

Então %r/^eu devo ver um link para a segunda página$/ do
  page.should have_content 2
end