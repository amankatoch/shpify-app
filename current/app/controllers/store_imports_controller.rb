class StoreImportsController < AuthenticatedController
  def new
    @store_import = StoreImport.new
  end

  def create
    @store_import = StoreImport.new(params[:store_import])
    if @store_import.save_to_current_shop(current_shop)
      redirect_to stores_url, notice: "Imported stores successfully."
    else
      render :new
    end
  end
end
