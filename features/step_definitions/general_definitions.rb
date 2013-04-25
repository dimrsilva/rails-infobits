# encoding: utf-8

Dado %r/^que eu esteja logado como administrador$/ do
  @user = FactoryGirl.create('admin/user')
  visit '/'
  fill_in 'Email', :with => @user.email
  fill_in 'Password', :with => @user.password
  click_button 'Sign in'
end

Quando %r/^eu clicar no botão de deletar o registro "([^"]*)"?/ do |label|
  row = page.find('table').find('tr', :text => label)
  row.find('a[data-method="delete"]').click()
end
 
Então %r/^eu devo ver "([^"]*)" no título$/ do |text|
  page.find('h1.title').should have_content text
end

Então %r/^eu (não )?devo ver o menu "([^"]*)"$/ do |negation, menu|
  within '.navbar' do
    if negation
      page.find('ul.nav').should_not have_content menu
    else
      page.find('ul.nav').should have_content menu
    end
  end
end

Então %r/^eu (não )?devo ver um formulário d(?:e|a|o) (.*)$/ do |negation, form|
  if negation
    page.should have_no_selector('form')
  else
    page.should have_selector('form')
  end
end

Então %r/^eu (não )?devo ver um resumo d(?:e|a|o) (.*)$/ do |negation, resume|
  if negation
    page.should have_no_selector('.view')
  else
    page.should have_selector('.view')
  end
end

Então(%r/^eu devo ver a mensagem "([^"]*)"$/) do |message|
  page.find('.system-messages').should have_content message
end