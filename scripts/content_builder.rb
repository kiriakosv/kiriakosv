require 'goodreads'

def books
  client = Goodreads::Client.new(
    api_key: ENV['GOODREADS_API_KEY'],
    api_secret: ENV['GOODREADS_SECRET_KEY']
  )

  intro = "I love reading 📚. Some of my latest readings from Goodreads are:\n"
  books = client.shelf(ENV['GOODREADS_USER_ID'], 'read').books.first(5)
                .map { |r| [r.book.title, r.book.link] }
                .map { |b| "* [#{b[0]}](#{b[1]})" }
                .join("\n")

  intro + books
end

bio = File.read('sections/bio.md')

File.open('README.md', 'w') do |f|
  f.puts bio
  f.puts "\n"
  f.puts books
  f.puts "\n"
  f.puts '---'
  f.puts "\n"
  f.puts '![.github/workflows/build.yml](https://github.com/kiriakosv/kiriakosv/workflows/.github/workflows/build.yml/badge.svg)'
  f.puts "\n"
  f.puts "Generated at `#{Time.now.utc.localtime('+03:00').strftime('%c %z')}`"
end
