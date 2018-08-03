require_relative 'block'
# require 'sqlite3'

# Chunk = Struct.new("Chunk", :owner, :dx, :dy, :dz, :blocks) do
#   def load_or_create
#     if 
#       db = SQLite3::Database.new("./world/db/#{dx}-#{dy}-#{dz}.db")
#       sql=<<EOS
# create table if not exists chunk (
#     owner string,
#     blocks string
# );
# EOS
#       db.execute(sql)
#       db.execute('insert into chunk (owner, blocks) values (?, ?) where not exists (select * from chunk)', ['', ''])
#       db.execute("select * from chunk") do |row|
#         p row
#       end    
#     end
#   end
# end

# test0 = Chunk.new("", 0, 0, 0, [])
# test0.load_or_create
# test1 = Chunk.new("", 0, 1, 0, [])
# test1.load_or_create
# test2 = Chunk.new("", 0, 2, 0, [])
# test2.load_or_create