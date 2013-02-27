module Utils
  def random_key(length=8)
    charset = %w{0 1 2 3 4 6 7 9  A B C D E F G H I J K L M N O P Q R S T U V W X Y Z ! @  $  *}
    (0...length).map{ charset.to_a[rand(charset.size)] }.join
  end

  module_function :random_key
end