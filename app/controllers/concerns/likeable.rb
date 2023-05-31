module Likeable
  def display_likes
    users = self.liking_users

    case users.length
    when 0
      'Nobody likes this'
    when 1
      "#{users[0].username} likes this"
    when 2
      "#{users[0].username} and #{users[1].username} like this"
    when 3
      "#{users[0].username}, #{users[1].username}, and #{users[2].username} like this"
    else
      "#{users.sample.username} and #{users.length - 1} others like this"
    end
  end
end
