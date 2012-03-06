class AuthenticatedAdminController < ApplicationController
  before_filter :authenticate_admin!
end
