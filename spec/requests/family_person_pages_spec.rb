require 'spec_helper'

describe "Family-Person pages" do

  subject { page }

  describe "index" do
    before(:each) do
      10.times {create(:person)}
      visit people_path
    end

    it { should have_title('Todos los Miembros') }

    describe "Members List" do

      it "should list each member" do
        Person.all.each do |person|
          expect(page).to have_link(person.name, href: person_path(person))
          expect(page).to have_selector('a', text: person.name)
        end
        Family.delete_all
      end
    end
  end # describe index

  describe "Edit Person" do
		let(:family) { create(:family) }
		let(:person) { family.family_members.create( name: "Fernando", first_last_name:"Garcia", second_last_name:"Lopez",  sex:"M", dob:"20/01/1995", family_roll: "Hijo") }
		before do
			visit edit_family_person_path(family,person)
		end

		describe "page" do
			it { should have_title("Editar a: Fernando Garcia Lopez") }
			it { should have_content("Editar a: Fernando Garcia Lopez") }
			it { should have_content("Regresar a Familia")}
		end

		describe "just clicking" do
			before { click_button "Guardar" }

			it { should have_content('Actualización Exitosa') }
			it { should have_selector('td', text:'M') }
			it { should have_selector('td', text:'Hijo') }
		end

		describe "with valid information" do
			before do
				fill_in "person[name]",           with: "Juan"
				fill_in "person[first_last_name]", with: "Perez"
				fill_in "person[second_last_name]", with: "Portilla"
				choose "person_sex_f"
				select 'Padre', from: 'person[family_roll]'

				click_button "Guardar"
			end

			it { should have_selector('div.alert.alert-success') }
			it { should have_content('Actualización Exitosa') }
			it { should have_selector('a', text:'Juan') }
			it { should have_selector('td', text:'F') }
			it { should have_selector('td', text:'Padre') }

			specify { expect(person.reload.name).to  eq "Juan" }
			specify { expect(person.reload.first_last_name).to  eq "Perez" }
			specify { expect(person.reload.second_last_name).to  eq "Portilla" }
			specify { expect(person.reload.sex).to  eq "F" }
			specify { expect(person.reload.family_roll).to  eq "Padre" }
		end

		describe "with valid information without modifying name and lastnames" do
			before do
				choose "person_sex_f"
				select 'Padre', from: 'person[family_roll]'

				click_button "Guardar"
			end

			it { should have_selector('div.alert.alert-success') }
			it { should have_content('Actualización Exitosa') }
			it { should have_selector('td', text:'F') }
			it { should have_selector('td', text:'Padre') }

			specify { expect(person.reload.sex).to  eq "F" }
			specify { expect(person.reload.family_roll).to  eq "Padre" }
		end
	end

end #describe-Family-Person-Pages



