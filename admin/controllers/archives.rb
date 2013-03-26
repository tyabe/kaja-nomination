KajaNomination::Admin.controllers :archives do
  get :index do
    @title = "Archives"
    @archives = Archive.all
    render 'archives/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'archive')
    @archive = Archive.new
    render 'archives/new'
  end

  post :create do
    @archive = Archive.new(params[:archive])
    if @archive.save
      @title = pat(:create_title, :model => "archive #{@archive.id}")
      flash[:success] = pat(:create_success, :model => 'Archive')
      params[:save_and_continue] ? redirect(url(:archives, :index)) : redirect(url(:archives, :edit, :id => @archive.id))
    else
      @title = pat(:create_title, :model => 'archive')
      flash.now[:error] = pat(:create_error, :model => 'archive')
      render 'archives/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "archive #{params[:id]}")
    @archive = Archive.find(params[:id])
    if @archive
      render 'archives/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'archive', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "archive #{params[:id]}")
    @archive = Archive.find(params[:id])
    if @archive
      if @archive.update_attributes(params[:archive])
        flash[:success] = pat(:update_success, :model => 'Archive', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:archives, :index)) :
          redirect(url(:archives, :edit, :id => @archive.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'archive')
        render 'archives/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'archive', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Archives"
    archive = Archive.find(params[:id])
    if archive
      if archive.destroy
        flash[:success] = pat(:delete_success, :model => 'Archive', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'archive')
      end
      redirect url(:archives, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'archive', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Archives"
    unless params[:archive_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'archive')
      redirect(url(:archives, :index))
    end
    ids = params[:archive_ids].split(',').map(&:strip).map(&:to_i)
    archives = Archive.find(ids)
    
    if Archive.destroy archives
    
      flash[:success] = pat(:destroy_many_success, :model => 'Archives', :ids => "#{ids.to_sentence}")
    end
    redirect url(:archives, :index)
  end
end
