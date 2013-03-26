KajaNomination::Admin.controllers :nominees do

  get :index do
    @title = "Nominees"
    @nominees = Nominee.where(archive_id: nil).all
    render 'nominees/index'
  end

  get :archive, '/nominees/archives/:name' do
    @title = "Nominees #{params[:name]}"
    @nominees = Archive.where(name: params[:name]).first.nominees
    render 'nominees/index'
  end

  put :move, 'nominees/archives/:name' do
    @title = "Nominees"
    unless params[:nominee_ids]
      redirect(url(:nominees, :index))
    end
    ids = params[:nominee_ids].split(',').map(&:strip).map(&:to_i)
    nominees = Nominee.find(ids)

    Archive.where(name: params[:name]).first.nominees << nominees

    redirect url(:nominees, :index)
  end

  get :new do
    @title = pat(:new_title, :model => 'nominee')

    if params[:account].present?
      @nominee = Nominee.search(params[:account], params[:provider])
      flash.now[:warning] = pat('account_not_found') unless @nominee
    end
    @nominee ||= Nominee.new

    render 'nominees/new'
  end

  post :create do
    @nominee = Nominee.new(params[:nominee])
    if @nominee.save
      @title = pat(:create_title, :model => "nominee #{@nominee.id}")
      flash[:success] = pat(:create_success, :model => 'Nominee')
      params[:save_and_continue] ? redirect(url(:nominees, :index)) : redirect(url(:nominees, :edit, :id => @nominee.id))
    else
      @title = pat(:create_title, :model => 'nominee')
      flash.now[:error] = pat(:create_error, :model => 'nominee')
      render 'nominees/new'
    end
  end

  get :edit, with: :id do
    @title = pat(:edit_title, :model => "nominee #{params[:id]}")
    @nominee = Nominee.find(params[:id])
    if @nominee
      render 'nominees/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'nominee', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, with: :id do
    @title = pat(:update_title, :model => "nominee #{params[:id]}")
    @nominee = Nominee.find(params[:id])
    if @nominee
      if @nominee.update_attributes(params[:nominee])
        flash[:success] = pat(:update_success, :model => 'Nominee', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:nominees, :index)) :
          redirect(url(:nominees, :edit, :id => @nominee.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'nominee')
        render 'nominees/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'nominee', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, with: :id do
    @title = "Nominees"
    nominee = Nominee.find(params[:id])
    if nominee
      if nominee.destroy
        flash[:success] = pat(:delete_success, :model => 'Nominee', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'nominee')
      end
      redirect url(:nominees, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'nominee', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Nominees"
    unless params[:nominee_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'nominee')
      redirect(url(:nominees, :index))
    end
    ids = params[:nominee_ids].split(',').map(&:strip).map(&:to_i)
    nominees = Nominee.find(ids)

    if Nominee.destroy nominees
      flash[:success] = pat(:destroy_many_success, :model => 'Nominees', :ids => "#{ids.to_sentence}")
    end
    redirect url(:nominees, :index)
  end

end
