KajaNomination.controllers :nominee do

  get :index, map: '/' do
    @nominees = Nominee.all
    render 'nominees/index'
  end

  get :show, map: '/nominees/:account' do
    @nominee = Nominee.find_by_account(params[:account])
    render 'nominees/show'
  end

end
