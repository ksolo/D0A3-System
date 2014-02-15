# encoding: UTF-8
require 'spec_helper'

describe "Family-Person pages" do

  subject { page }

  describe "index" do
	  let(:family) { create(:family) }
	  let(:user) { create(:user) }
		let(:person1) { family.family_members.create( name: "Fernando", first_last_name:"Garcia", second_last_name:"Lopez",  sex:"M", dob:"20/01/1995", family_roll: "Hijo") }
		let(:person2) { family.family_members.create( name: "Alejandra", first_last_name:"Garcia", second_last_name:"Lopez",  sex:"F", dob:"21/02/1996", family_roll: "Hija") }
		let(:person3) { family.family_members.create( name: "Rodrigo", first_last_name:"Garcia", second_last_name:"Lopez",  sex:"M", dob:"22/03/1969", family_roll: "Padre") }
    
    before(:each) do
      sign_in user
      visit family_path(family)
    end

    it { should have_title('Familia:') }
    it { should have_button("Falta Información de Contacto")}
		it { should have_link("Falta Información de Contacto", href: new_family_address_path(family))}
		it { should have_button("Regresar a Socios") }
		it { should have_link("Regresar a Socios", href: families_path ) }

    describe "Members List" do

      it "should list each member" do
        Person.all.each do |person|
          expect(page).to have_link(person.name, href: person_path(person))
          expect(page).to have_selector('a', text: person.name)
          expect(page).to have_selector('a', text: person.name)
          expect(page).to have_selector('td', text: person.first_last_name) 
          expect(page).to have_selector('td', text: person.second_last_name) 
          expect(page).to have_selector('td', text: person.dob) 
          expect(page).to have_selector('td', text: person.family_roll) 
        end
      end
    end
  end # describe index

  describe "New Person" do
		let(:family) { create(:family) }
		let(:person) { family.family_members.create( name: "Fernando", first_last_name:"Garcia", second_last_name:"Lopez",  sex:"M", dob:"20/01/1995", family_roll: "Hijo") }
		before do
			visit new_family_person_path(family,person)
		end

		describe "page" do
			it { should have_title("Nuevo Miembro:") }
			it { should have_content("Nuevo Miembro:") }
			it { should have_button("Regresar a Familia")}
			it { should have_link("Regresar a Familia", href: family_path(family))}
			# No sirvio escrito de la manera del siguiente renglon
			# it { should have_link("Regresar a Familia", href: families_path(family))}
		end

		describe "just clicking" do
			before { click_button "Guardar" }

			it { should have_content('The form contains 6 errors.') }
		end

		describe "with valid information" do
			before do
				fill_in "person[name]",           with: "Juan"
				fill_in "person[first_last_name]", with: "Perez"
				fill_in "person[second_last_name]", with: "Portilla"
				choose "person_sex_f"
				select 'Padre', from: 'person[family_roll]'
				select  '1995', from: 'person[dob(1i)]'
				select  'February' , from: 'person[dob(2i)]'
				select  '21' , from: 'person[dob(3i)]'

				# within '#person_dob_3i' do
				#   find("option[2]").select_option
				#   find(:xpath, 'option[2]').select_option
				# end

				expect { click_button "Guardar" }.to change(family.family_members, :count).by(1)
			end

			it { should have_selector('div.alert.alert-success') }
			it { should have_content('Creación Exitosa') }
			it { should have_selector('a', text:'Juan') }
			it { should have_selector('td', text:'F') }
			it { should have_selector('td', text:'Padre') }
			it { should have_selector('td', text:'1995-02-21') }



			specify { expect(person.name).to  eq "Fernando" }
			specify { expect(person.first_last_name).to  eq "Garcia" }
			specify { expect(person.second_last_name).to  eq "Lopez" }
			specify { expect(person.sex).to  eq "M" }
			specify { expect(person.family_roll).to  eq "Hijo" }
			specify { expect(person.dob).to  eq "20/01/1995".to_date }
		end

    describe "with invalid information" do
      it "should not create a person" do
        expect { click_button "Guardar" }.not_to change(Person, :count)
      end

      describe "after submission" do
        before { click_button "Guardar" }

       	it { should have_title("Nuevo Miembro:") }
        it { should have_content('The form contains 6 errors.') }
      end
    end

	end # new person


  describe "Edit Person" do
		let(:family) { create(:family) }
		let(:person) { family.family_members.create( name: "Fernando", first_last_name:"Garcia", second_last_name:"Lopez",  sex:"M", dob:"20/01/1995", family_roll: "Hijo") }
		before do
			visit edit_family_person_path(family,person)
		end

		describe "page" do
			it { should have_title("Editar a: Fernando Garcia Lopez") }
			it { should have_content("Editar a: Fernando Garcia Lopez") }
			it { should have_button("Regresar a Familia")}
			it { should have_link("Regresar a Familia", href: "/families/#{family.id}")}
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
				select  '2002', from: 'person[dob(1i)]'
				select  'February' , from: 'person[dob(2i)]'
				select  '21' , from: 'person[dob(3i)]'
				# Otra forma de hacerlo	
				# within '#person_dob_3i' do
				#   find("option[value='21']").select_option
				# end

				click_button "Guardar"
			end

			it { should have_selector('div.alert.alert-success') }
			it { should have_content('Actualización Exitosa') }
			it { should have_selector('a', text:'Juan') }
			it { should have_selector('td', text:'F') }
			it { should have_selector('td', text:'Padre') }
			it { should have_selector('td', text:'2002-02-21') }

			specify { expect(person.reload.name).to  eq "Juan" }
			specify { expect(person.reload.first_last_name).to  eq "Perez" }
			specify { expect(person.reload.second_last_name).to  eq "Portilla" }
			specify { expect(person.reload.sex).to  eq "F" }
			specify { expect(person.reload.family_roll).to  eq "Padre" }
			specify { expect(person.reload.dob).to  eq "2002-02-21".to_date }
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
	end # Edit Person

	

end #describe-Family-Person-Pages



