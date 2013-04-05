class Contacts::CompaniesController < Contacts::ContactsController
  before_filter :parse_representant_id

  def parse_representant_id
    if params[:contact_company] && params[:contact_company][:representant]
      id = params[:contact_company][:representant].scan(%r/\[id:(\d+)\]$/)[0][0].to_i
      params[:contact_company][:representant] = Contact::Person.find(id)
    end
  end
end
