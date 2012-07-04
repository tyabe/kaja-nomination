KajaNomination.controllers :nominee do

  get :index, map: '/' do
    @nominees = Nominee.all
    render 'nominees/index'
  end

  get :show, map: '/nominees/:account' do
    @nominee = Nominee.find_by_account(params[:account])
    render 'nominees/show'
  end

  get :new, map: '/nominee/:account/vote' do
    @nominee = Nominee.find_by_account(params[:account])
    @ballot = @nominee.ballots.new(user: current_user)
    render 'nominees/vote'
  end

  post :create, map: '/nominee/:account/vote' do
    @nominee = Nominee.find_by_account(params[:account])
    @ballot = @nominee.ballots.new(params[:ballot].merge(user: current_user))
    if @ballot.save
      flash[:notice] = 'Vote was successfully created.'
      redirect url(:nominee, :show, account: @nominee.account)
    else
      render 'nominees/vote'
    end

  end

end
