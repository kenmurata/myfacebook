class CommentsController < ApplicationController
    def create
        @comment = current_user.comments.build(comment_params)
        @topic = @comment.topic
        
        respond_to do |format|
            if @comment.save
                format.html { redirect_to topic_path(@topic), notice: 'コメント投稿しました' }
                format.js { render :index }
            else
                format.html { render :new }
            end
        end
    end
    
    def edit
        @comment = Comment.find(params[:id])
        redirect_to topic_path(comment_params[:topic_id])
    end
    
    def update
        @comment = Comment.find(params[:id])
        @topic = @comment.topic
        respond_to do |format|
            if @comment.save
                format.html { redirect_to topic_path(@topic), notice: 'コメント更新しました' }
                format.js { render :index }
            else
                format.html { render :new }
            end
        end
    end
    
    private
        def comment_params
            params.require(:comment).permit(:topic_id, :content)
        end
end