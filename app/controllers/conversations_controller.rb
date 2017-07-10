class ConversationsController < ApplicationController
  
  before_action :authenticate_user!
  
  def index
    @users = User.all
    @conversations = Conversation.all
  end

  def create
    if Conversation.between(params[:sender_id], params[:recipient_id]).present?
      @conversation = Conversation.between(params[:sender_id], params[:recipient_id])
    else
      @conversation = Conversation.create!(conversation_params)
    end
    
    @conversation = Conversation.between(conversation_params[:sender_id],conversation_params[:recipient_id])
    redirect_to conversation_messages_path(conversation_id: @conversation.pluck[0][0], sender_id: conversation_params[:sender_id], recipient_id: conversation_params[:recipient_id])
  end
  
  private
    def conversation_params
      params.permit(:sender_id, :recipient_id)
    end
end