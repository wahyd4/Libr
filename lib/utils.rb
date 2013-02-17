module Utils
  def random_key
    charset = %w{0 1 2 3 4 6 7 9 A C D E F G H I J K L M N O P Q R S T U V W X Y Z ! @ # $ % & *}
    (0...6).map{ charset.to_a[rand(charset.size)] }.join
  end

  module_function :random_key
end