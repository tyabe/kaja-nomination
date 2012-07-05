Admin.controllers :base do

  get :index, :map => "/" do
    redirect url(:nominees, :index)
  end
end
