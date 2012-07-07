Admin.controllers :nominees do

  get :index do
    @nominees = Nominee.all
    render 'nominees/index'
  end

  get :new do
    @nominee = begin
                 if params[:account].present?
                   Nominee.search(params[:account], params[:provider])
                 else
                   Nominee.new
                 end
               end
    render 'nominees/new'
  end

  post :create do
    @nominee = Nominee.new(params[:nominee])
    if @nominee.save
      flash[:notice] = pat('created_nominee')
      redirect url(:nominees, :index)
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
      flash[:notice] = pat('updated_nominee')
      redirect url(:nominees, :index)
    else
      render 'nominees/edit'
    end
  end

  delete :destroy, :with => :id do
    nominee = Nominee.find(params[:id])
    nominee.destroy
    flash[:notice] = pat('destroyed_nominee')
    redirect url(:nominees, :index)
  end
end
