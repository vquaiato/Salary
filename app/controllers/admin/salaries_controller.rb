class Admin::SalariesController < AuthenticatedAdminController
  respond_to :html
  
  def index
    @salaries = Salary.all
    respond_with @salaries
  end
  
  def destroy
    salary = Salary.find params[:id]
    salary.delete
    redirect_to admin_salaries_path
  end
end
