module CommentsHelper
  def user_is_authorized_for_comment?(comment)
      current_user && (current_user == comment.user || current_user.admin?)
   end

   def user_has_any_comments?(user)
     if user.comments.any?
       render(user.comments)
     else
       content_tag :p do
         "#{user.name} doens't have any comments yet!"
       end
     end
   end
end
