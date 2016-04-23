module PostsHelper
  def user_is_authorized_for_post?(post)
        current_user && (current_user == post.user || current_user.admin?)
   end

   def user_has_any_posts?(user)
     if user.posts.any?
       render(user.posts)
     else
       content_tag :p do
         "#{user.name} doens't have any posts yet!"
       end
     end
   end
end
