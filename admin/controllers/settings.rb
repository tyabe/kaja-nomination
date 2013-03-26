KajaNomination::Admin.controllers :settings do

  get :index do
    render 'settings/edit'
  end

  put :update do
    params.each do |name, value|
      next unless Setting.has_key?(name)
      Setting[name] = value
    end
    Setting.clear_cache
    flash[:notice] = 'Setting was successfully updated.'
    redirect url(:settings, :index)
  end

end
