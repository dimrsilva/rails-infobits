# encoding: utf-8

Dado %r/^que eu visite a url "([^"]*)"$/ do |page|
  visit page
end

Quando %r/^eu preencher o campo "([^"]*)" com o valor "([^"]*)"/ do |field, value|
  fill_in field, :with => value
end

Quando %r/^eu confirmar a mensagem de alerta$/ do
  page.driver.browser.switch_to.alert.accept
end

Então %r/^eu devo ver o link "([^"]*)"/ do |link|
  page.find_link link
end

Então %r/^eu devo ver o texto "([^"]*)"/ do |text|
  page.should have_content text
end

Então(/^eu devo ver o um checkbox com o valor "(.*?)"$/) do |val|
  pending
end