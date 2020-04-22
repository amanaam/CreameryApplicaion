class StoresController < ApplicationController
  before_action :set_store, only: [:show, :edit, :update, :details]
  before_action :check_login
  authorize_resource
  def index
    unless current_user.role?(:employee)
      @active_stores = Store.active.paginate(:page => params[:page]).per_page(5)
      @inactive_stores = Store.inactive.paginate(:page => params[:page]).per_page(5)
    end
  end

  def edit
  end
    
  def details
  end
  
  def new
      @store = Store.new
  end
  
  def create
      @store = Store.new(store_params)
      if @store.save
          redirect_to @store, notice: "Added store information for #{@store.name}."
      else
          render action: 'new'
      end
  end
  
  def update
      if @store.update(store_params)
          redirect_to @store, notice: "Updated store information for #{@store.name}."
      else
          render action: 'edit'
      end
  end
      
  def show
      @current_managers = Assignment.current.for_store(@store).for_role('manager').map{|a| a.employee}
      @current_employees = Assignment.current.for_store(@store).map{|a| a.employee}
  end
  
  private
    def set_store
      @store = Store.find(params[:id])
    end
  
    def store_params
      params.require(:store).permit(:name, :street, :city, :state, :zip, :phone, :active)
    end
end
