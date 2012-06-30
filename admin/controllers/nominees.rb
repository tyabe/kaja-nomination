Admin.controllers :nominees do

  get :index do
    @nominees = Nominee.all
    render 'nominees/index'
  end

  get :new do
    @nominee = Nominee.new
    render 'nominees/new'
  end

  post :create do
    @nominee = Nominee.new(params[:nominee])
    if @nominee.save
      flash[:notice] = 'Nominee was successfully created.'
      redirect url(:nominees, :edit, :id => @nominee.id)
    else
      render 'nominees/new'
    end
  end

  get :edit, :with => :id do
    @nominee = Nominee.find(params[:id])
    render 'nominees/edit'
  end

  put :update, :with => :id do
    @nominee = Nominee.find(params[:id])
    if @nominee.update_attributes(params[:nominee])
      flash[:notice] = 'Nominee was successfully updated.'
      redirect url(:nominees, :edit, :id => @nominee.id)
    else
      render 'nominees/edit'
    end
  end

  delete :destroy, :with => :id do
    nominee = Nominee.find(params[:id])
    if nominee.destroy
      flash[:notice] = 'Nominee was successfully destroyed.'
    else
      flash[:error] = 'Unable to destroy Nominee!'
    end
    redirect url(:nominees, :index)
  end
end
