class RecommendService

  def sort_books_by_popularity(books)
    books.group_by { |book| book }.sort_by { |k, v| v.count }.reverse.map { |k, v| k = k, v = v.count }
  end


  def get_books_from_users(users)
    books = []
    users.each { |user| books += user.book_instances }
    books.map! { |book| book.sortable_book }
  end


  def sort_users_books_by_popularity(users)
    sort_books_by_popularity get_books_from_users(users)
  end


  def get_similar_users(target_user)
    filtered_user = User.all.select { |user| (user.book_ids & target_user.book_ids).length > 0 }
    filtered_user.sort_by { |user| (user.book_ids & target_user.book_ids).length }.reverse
  end

end