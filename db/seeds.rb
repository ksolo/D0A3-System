require "csv"

def load_file(file)
	array = []
	file_text = File.read(file)
	csv = CSV.parse(file_text, :headers => true, :header_converters => :symbol)
	csv.each do |row|
	  array << row.to_hash
	end
	array
end

load_file("members.csv").each do |line| 
	Person.create(line)
end

load_file("families.csv").each do |line| 
	Family.create(line)
end

load_file("family_relations.csv").each do |line| 
	FamilyRelation.create(line)
end