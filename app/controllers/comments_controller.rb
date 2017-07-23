class CommentsController < ApplicationController
    def create
        @comment = current_user.comments.build(comment_params)
        @topic = @comment.topic
        
        respond_to do |format|
            if @comment.save
                format.html { redirect_to topic_path(@topic), notice: 'コメント投稿しました' }
                format.js { render :index }
            else
                format.html { redirect_to topic_path(@topic) }
                format.js { render :index }
            end
        end
    end
    
    def edit
        @comment = Comment.find(params[:id])
        @topic = Topic.find(params[:topic_id])
    end
    
    def update
        @comment = Comment.find(params[:id])
        p comment_params[:content]
        @comment.content = comment_params[:content]
        @topic = @comment.topic
        respond_to do |format|
            if @comment.save
                format.html { redirect_to topic_path(@topic)}
                format.js { render :index }
            else
                format.html { render :new }
            end
        end
    end
    
    def destroy
        @comment = Comment.find(params[:id])
        @topic = Topic.find(params[:topic_id])
        respond_to do |format|
            if @comment.destroy
                format.html { redirect_to topic_path(@topic), notice: 'コメントを削除しました' }
                format.js { render :index }
            else
                format.html { render :new }
            end
        end
    end
    
    private
        def comment_params
            params.require(:comment).permit(:content, :topic_id)
        end
end