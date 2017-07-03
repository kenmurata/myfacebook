class TopicsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_at_topic, only: [:show, :edit, :update, :destroy]
    
    def index
        @topics = Topic.all.order(:id)
    end
    
    def show
        @comments = @topic.comments
        @comment = @topic.comments.build
    end
    
    def edit
    end
    
    def destroy
        @topic.destroy
        redirect_to root_path, notice: '削除完了！'
    end
    
    def new
        @topic = Topic.new
    end
    
    def create
        @topic = Topic.new(topic_params)
        @topic.user_id = current_user.id
        if @topic.save
            redirect_to topics_path, notice: '投稿が完了しました!'
        else
            render 'new'
        end
    end
    
    def update
        if @topic.update(topic_params)
            redirect_to topics_path, notice: '投稿が完了しました!'
        else
            render 'edit'
        end
    end
    
    
    private
        def topic_params
            params.require(:topic).permit(:title, :content)
        end
        def set_at_topic
            @topic = Topic.find(params[:id])
        end
end
