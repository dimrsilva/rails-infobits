# encoding: utf-8

Dado %r/^que eu esteja logado como administrador$/ do
  @group = FactoryGirl.create('contact/group', :acts_as_administrator => true)
  @person = FactoryGirl.create('contact/person')
  @person.groups << @group
  @person.save
  @user = FactoryGirl.create('admin/user', :contact => @person)
  visit '/'
  fill_in 'Email', :with => @user.email
  fill_in 'Password', :with => @user.password
  click_button 'Sign in'
end

Dado %r/^que eu esteja logado como o usuário "([^"]*)"$/ do |email|
  visit '/'
  fill_in 'Email', :with => email
  fill_in 'Password', :with => '123'
  click_button 'Sign in'
end

Quando %r/^eu clicar no botão de (\w+) o registro "([^"]*)"?/ do |action, label|
  @grouptag ||= 'table.table>tbody'
  @rowtag ||= 'tr'
  row = page.find(@grouptag).find(@rowtag, :text => label)
  if action == 'visualizar'
    row.find('a.view').click()
  elsif action == 'deletar'
    row.find('a.destroy').click()
  else
    raise "Nao achou botao"
  end
end

Então %r/^eu( não)? devo ver um botão de (\w+) para o registro "([^"]*)"?/ do |negation, action, label|
  @grouptag ||= 'table.table>tbody'
  @rowtag ||= 'tr'
  row = page.find(@grouptag).find(@rowtag, :text => label)
  if action == 'visualizar'
    if negation
      row.should_not have_selector('a.view')
    else
      row.should have_selector('a.view')
    end
  elsif action == 'remover'
    if negation
      row.should_not have_selector('a.destroy')
    else
      row.should have_selector('a.destroy')
    end
  else
    raise "Nao achou botao"
  end
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

Então %r/^eu devo ver uma tabela com (\d+) (\w+)$/ do |qtd, objtype|
  @grouptag = 'table.table>tbody'
  @rowtag = 'tr'
  page.find(@grouptag).all('tr').count.should eql qtd.to_i
end

Então %r/^eu devo ver uma linha para (?:o|a) (\w+) "([^"]*)"$/ do |objtype, label|
  @grouptag ||= 'table.table>tbody'
  @rowtag ||= 'tr'
  page.find(@grouptag).find(@rowtag, :text => label)
end