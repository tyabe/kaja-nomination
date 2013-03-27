KajaNomination::App.controllers :nominee do

  before :vote do
    unless current_user
      flash[:warn] = t('app.please_login')
      redirect '/'
    end
  end
  before :new, :create do
    unless current_user
      flash[:warn] = t('app.please_login')
      redirect '/'
    end

    account = (params[:account] || params[:nominee]&&params[:nominee][:github_id])
    if account && Nominee.where(archive_id: nil, github_id: account).first
      flash[:alert] = t('app.already_registered')
      redirect url(:nominee, :show, account)
    end
  end

  get :index, '/' do
    @nominees = Nominee.where(archive_id: nil).all
    render 'nominees/index'
  end

  get :show, '/nominees/:account' do
    @nominee = Nominee.where(archive_id: nil).find_by_account(params[:account])
    render 'nominees/show'
  end

  get :vote, '/nominee/:account/vote' do
    @nominee = Nominee.where(archive_id: nil).find_by_account(params[:account])
    @ballot = @nominee.find_or_new(current_user)
    render 'nominees/vote'
  end

  post :vote, '/nominee/:account/vote' do
    @nominee = Nominee.where(archive_id: nil).find_by_account(params[:account])
    @ballot = @nominee.ballots.new(params[:ballot].merge(user: current_user))
    if @ballot.save
      flash[:notice] = t('app.voted')
      redirect url(:nominee, :show, account: @nominee.account)
    else
      render 'nominees/vote'
    end
  end

  put :vote, '/nominee/:account/vote' do
    @nominee = Nominee.where(archive_id: nil).find_by_account(params[:account])
    @ballot = @nominee.ballots.find_by_user_id(current_user)
    if @ballot.update_attributes(params[:ballot])
      flash[:notice] = t('app.updated_comment')
      redirect url(:nominee, :show, account: @nominee.account)
    else
      render 'nominees/vote'
    end
  end

  get :new do
    if params[:account].present?
      @nominee = Nominee.search(params[:account])
      flash.now[:warning] = t('app.account_not_found') unless @nominee
    end
    @nominee ||= Nominee.new

    render 'nominees/new'
  end

  post :create, '/nominees/new' do
    @nominee = Nominee.new(params[:nominee])
    logger.info params
    if @nominee.save
      @nominee.ballots.create(user: current_user, comment: params[:nominee][:description])
      flash[:notice] = t('app.created_nominee')
      redirect url(:nominee, :show, @nominee.account)
    else
      render 'nominees/new'
    end
  end

end
