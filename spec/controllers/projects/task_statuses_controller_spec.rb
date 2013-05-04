require 'spec_helper'

describe Projects::TaskStatusesController do
  it_behaves_like "Authenticated resource"
  it_behaves_like "Paginated resource"
  it_behaves_like "Crud resource"
end
