# encoding: utf-8

Dado %r/^que existam? (\d+) contatos no grupo "([^"]*)"$/ do |n, name|
  @group = FactoryGirl.create "contact/group", :name => name

  n.to_i.times do
    @contact = FactoryGirl.create "contact/contact"
    @contact.groups << @group
    @contact.save
  end
end
