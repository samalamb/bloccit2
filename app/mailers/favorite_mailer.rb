class FavoriteMailer < ApplicationMailer
  default from: "samuel.dieck@gmail.com"

  def new_comment(user, post, comment)

# #18
    headers["Message-ID"] = "<comments/#{comment.id}@your-app-name.example>"
    headers["In-Reply-To"] = "<post/#{post.id}@your-app-name.example>"
    headers["References"] = "<post/#{post.id}@your-app-name.example>"

    @user = user
    @post = post
    @comment = comment

# #19
    mail(to: user.email, subject: "New comment on #{post.title}")
  end

  def new_post(user, post)
    headers["Message-ID"] = "<>"
    headers["In-Reply-To"] = "<post/#{post.id}@your-app-name.example>"
    headers["References"] = "<post/#{post.id}@your-app-name.example>"

    @user = user
    @post = post

# #19
    mail(to: user.email, subject: "Favorited #{post.title}")
  end
end
