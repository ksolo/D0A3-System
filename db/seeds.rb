
require "csv"

User.create( name: "Juan", email: "flaco@gmail.com", password: "123qwe123", password_confirmation: "123qwe123" )
User.create( name: "javier", email: "javier@deceroatres.com", password: "deceroatres", password_confirmation: "deceroatres" )

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


families = Family.all

families.each do |f|
	f.family_relations.each do |rel|
		if(rel.person)
			if(rel.person.family_roll=='Madre')
				f.responsible_id = rel.person.id
			end
		end
		f.save
	end
end