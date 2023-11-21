class Friend < Friendship
  def friendship_over(user, friend)
    user_friend_record = Friendship.find_by(
      user_id: user.id, friend_id: friend.id
    )
    mutual_friend_record = Friendship.find_by(
      user_id: friend.id, friend_id: user.id
    )

    user_friend_record.destroy
    mutual_friend_record.destroy
  end
end
