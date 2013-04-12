# encoding: utf-8

Dado %r/^que existam (\d+) contatos cadastrados$/ do |n|
  model = Contact::Contact
  n.to_i.times do
    model.create
  end
end

Dado %r/^que exista um contato com nome "([^"]*)"$/ do |name|
  Contact::Contact.create :fullname => name
end

Então %r/^eu devo ver um link para a (\d+)º página$/ do |p|
  page.find(".pagination").find_link p
end
