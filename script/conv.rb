require 'sqlite3'
db = SQLite3::Database.new("toefl.db")

line_num = 0
text = File.open('toeflu8.txt').read
text.gsub!(/\r\n?/, "\n")
text.each_line do |line|
  line_num += 1
  if line_num % 2 != 0
    db.execute("insert into 'words' ('id', 'en') values (?, ?)", (line_num+1)/2, line)
  else
    db.execute("update 'words' set zh = ? where id = ?", line, line_num/2)
  end
  print "#{line_num} #{line}"
end