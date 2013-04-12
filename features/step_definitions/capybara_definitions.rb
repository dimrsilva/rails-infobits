# encoding: utf-8

Dado %r/^que eu visite a url "([^"]*)"$/ do |page|
  visit page
end

Quando %r/eu preencher o campo "([^"]*)" com o valor "([^"]*)"/ do |field, value|
  fill_in field, :with => value
end

Então %r/eu devo ver o link "([^"]*)"/ do |link|
  page.find_link link
end

Então %r/eu devo ver o texto "([^"]*)"/ do |text|
  page.should have_content text
end
