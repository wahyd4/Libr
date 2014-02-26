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

end