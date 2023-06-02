module Likeable
  def display_likes
    users = self.liking_users

    case users.length
    when 0
      'Nobody likes this'
    when 1
      "#{users[0].fullname} likes this"
    when 2
      "#{users[0].fullname} and #{users[1].fullname} like this"
    when 3
      "#{users[0].fullname}, #{users[1].fullname}, and #{users[2].fullname} like this"
    else
      "#{users.sample.fullname} and #{users.length - 1} others like this"
    end
  end
end
