class ArticlesController < ApplicationController
    def index
        @articles = policy_scope(Article)
    end
    
    def show
        @article = Article.find(params[:id])
        authorize @article    
    end
 
    def new
        @user = current_user
        @article = Article.new
        authorize @article
    end

    def edit
        @article = Article.find(params[:id])
        authorize @article
    end        

    def create
        @user = current_user
        @article = Article.new(article_params)
        @article.user = current_user
        authorize @article
        
        if @article.save
            redirect_to @article, notice: "Article saved."
        else
            flash[:error] = "Error."
            render 'new'
        end
    end
    
    def update
        @article = Article.find(params[:id])
        authorize @article
        if @article.update(article_params)
            flash[:error] = "Article updated."
            redirect_to @article
        else
            flash[:error] = "Error."
            render 'edit'
        end
    end

    def destroy
        @article = Article.find(params[:id])
        authorize @article
        if @article.destroy
            flash[:notice] = "Article deleted."
            redirect_to articles_path
        else
            flash[:error] = "Error."
            render 'show'
        end
    end

    private
        def article_params
            params.require(:article).permit(:title, :text, :user, :user_id)
        end
end