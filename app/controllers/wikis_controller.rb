class WikisController < ApplicationController
  before_action :login_required, :no_locked_required, except: [:index, :show, :search]

  def index
	@wikis = Wiki.all
  end

  def new
  	@wiki = Wiki.new
  end

  def create
  	@wiki = current_user.wikis.create wiki_params
  end


  def show
  	@wiki = Wiki.find_by_slug(params[:slug])
  	#@wiki = Wiki.find(params[:id])
    toc_file = "#{Rails.root}/public/material_design/TOC.md"
    @toc = File.read(toc_file)

    readme = "#{Rails.root}/public/material_design/README.md"
    @content = File.read(readme)

    #@comments = @wiki.comments.includes(:user).order(id: :asc).page(params[:page])
  end

  def edit
  	@wiki = Wiki.find(params[:id])
  end

  def update
  	@wiki = Wiki.find(params[:id])
  	@wiki.update_attributes(wiki_params)
    if @wiki.save
      flash[:notice] = "succ.."
      redirect_to wikis_path()
    else
      render :action => 'edit',:id=>@wiki.id
    end
  end

  def page
  	@wiki = Wiki.find_by_slug(params[:slug])
    @page_slug = params[:page_slug]
  	#@page = Page.find_by_slug(@page_slug)
    toc_file = "#{Rails.root}/public/material_design/TOC.md"
    @toc = File.read(toc_file)

    file = "#{Rails.root}/public/material_design/#{params[:page_slug]}.md"
    #logger.info("file=#{file}")
    if File.exists?(file) 
      #logger.info("yep,,,,,")
      @content = File.read(file)
      #logger.info("content=#{@content}")
    else
      "nop...."
    end
  	# unless @page
		 #  redirect_to edit_page_wiki_path(:slug=>@wiki.slug)
  	# end
  	render :action => :show
  end

  private
  def wiki_params
      params.require(:wiki).permit(:title, :slug, :source,:body,:github, :git)
  end

end
