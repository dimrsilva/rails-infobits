# encoding: utf-8

Dado %r/^que existam (\d+) contatos cadastrados$/ do |n|
  model = Contact::Contact
  n.to_i.times do
    model.create
  end
end

Dado %r/^que exista uma? (\w+) com nome "([^"]*)"$/ do |type, name|
  model = Contact::Contact
  field = :fullname
  case type
    when 'pessoa'
      model = Contact::Person
      field = :firstname
    when 'empresa'
      model = Contact::Company
      field = :fantasy_name
  end
  model.create field => name
end

Dado(/^que o representante d(?:e|a|o) "(.*?)" seja "(.*?)"$/) do |company_name, person_name|
  person = Contact::Contact.find_by_fullname person_name
  company = Contact::Contact.find_by_fullname company_name
  company.representant = person
  company.save
end

Então %r/^eu devo ver um link para a (\d+)º página$/ do |p|
  page.find(".pagination").find_link p
end
