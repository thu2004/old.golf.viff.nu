class Admin::DialogsController < Admin::BaseController

  layout 'admin_dialog'

  def show
    @dialog_type = params[:id].try(:downcase)

    if @dialog_type
      @submit_button_text = "Insert"
      @cancel_button_text = "Cancel"

      url_params = params.reject {|key, value| key =~ /(action)|(controller)/}

      @iframe_src = if @dialog_type == 'image'
        insert_admin_images_url(:modal => true)
      elsif @dialog_type == 'link'
        link_to_admin_pages_dialogs_url(url_params)
      end

      render :layout => false

    else
      render :nothing => true
    end
  end

end
