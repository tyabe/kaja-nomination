KajaNomination.controllers :nominee do
  before :new, :create do
    unless current_user
      session[:return_to] = request.fullpath
      redirect '/auth/github'
    end
  end

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
    @ballot = @nominee.find_or_new(current_user)
    render 'nominees/vote'
  end

  post :vote, map: '/nominee/:account/vote' do
    @nominee = Nominee.find_by_account(params[:account])
    @ballot = @nominee.ballots.new(params[:ballot].merge(user: current_user))
    if @ballot.save
      flash[:notice] = t('app.voted')
      redirect url(:nominee, :show, account: @nominee.account)
    else
      render 'nominees/vote'
    end
  end

  put :vote, map: '/nominee/:account/vote' do
    @nominee = Nominee.find_by_account(params[:account])
    @ballot = @nominee.ballots.find_by_user_id(current_user)
    if @ballot.update_attributes(params[:ballot])
      flash[:notice] = t('app.updated_comment')
      redirect url(:nominee, :show, account: @nominee.account)
    else
      render 'nominees/vote'
    end
  end

end
