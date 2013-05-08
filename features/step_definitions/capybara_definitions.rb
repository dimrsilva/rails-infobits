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

Então %r/^eu (não )?devo ver o link "([^"]*)"$/ do |negation, menu|
    if negation
      page.should_not have_selector('a', :text => menu)
    else
      page.should have_selector('a', :text => menu)
    end
end

Então %r/^eu (não )?devo ver o botão "([^"]*)"$/ do |negation, menu|
    if negation
      expect {
        page.find_button menu
      }.to raise_error
    else
      page.find_button menu
    end
end

Então %r/^eu devo ver o texto "([^"]*)"/ do |text|
  page.should have_content text
end

Então(/^eu devo ver o um checkbox com o valor "(.*?)"$/) do |val|
  pending
end