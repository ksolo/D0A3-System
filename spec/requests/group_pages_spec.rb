# encoding: UTF-8
require 'spec_helper'

describe 'Group pages' do
	subject { page }

	let(:user) { create(:user) }
	let(:group) { create(:group) }
	let(:lecture) { create( :lecture, group: group ) }

  	before do
		sign_in user
		10.times { create(:group) }
		10.times { create(:spot, group: group ) }
		visit groups_path
	end

	describe 'Index Groups' do
		it { should have_title('Nuestros Grupos') }
		it { should have_content(Group.all.count) }
		describe 'Should render group list' do
			it "should list each group" do
				Group.all.each do |g|
					expect(page).to have_selector('a', text: g.name)
				end
			end
		end
	end

	describe 'Show group information' do

		before { visit group_path(group) }

		describe 'Show group information' do
			it { should have_title("Grupo #{group.name}") }
			it { should have_link('Nueva Clase') }
			it { should have_link('Editar Grupo') }
		end

		describe "visiting the edit group" do
          before { visit edit_group_path(group) }
          it { should have_title('Editar Grupo') }
          it { should have_content('Datos del grupo') }
        end

        describe "with invalid information" do
        	before do
          		visit edit_group_path(group)
          		fill_in "group[name]", :with => " "
          	end
			it "should not update a group" do
				expect { click_button "Guardar" }
			end
			describe "error messages" do
				before { click_button "Guardar" }
				it { should have_content('error') }
			end
		end

		describe "with valid information" do
			before do
				visit edit_group_path(group)
				fill_in "group[name]", :with => "Renamed Group"
				select '1999', from: "group[init_date(1i)]"
				select "January", from: "group[init_date(2i)]"
				select "12", from: "group[init_date(3i)]"
				select "2000", from: "group[finish_date(1i)]"
				select "January", from: "group[finish_date(2i)]"
				select "12", from: "group[finish_date(3i)]"
				fill_in "group[min_age]", :with => "0"
				fill_in "group[max_age]", :with => "100"
				fill_in "group[cost]", :with => "999"
				fill_in "group[location]", :with => "Aula Dos"

				click_button "Guardar"
			end

			it { should have_selector("div.alert.alert-success") }
			it { should have_content('Actualización Exitosa') }
			it { should have_selector('td', text: "Renamed Group" ) }
			it { should have_selector('td', text: '0' ) }
			it { should have_selector('td', text: '100' ) }
			it { should have_selector('td', text: '999' ) }
			it { should have_selector('td', text: "Aula Dos" ) }
			it { should have_selector('td#init', text: "01/12/1999" ) }
			it { should have_selector('td#finish', text: "01/12/2000" ) }

			specify { expect(group.reload.name).to eq "Renamed Group" }
			specify { expect(group.reload.min_age).to eq 0 }
			specify { expect(group.reload.max_age).to eq 100 }
			specify { expect(group.reload.cost).to eq 999 }
			specify { expect(group.reload.location).to eq "Aula Dos" }
			specify { expect(group.reload.init_date).to eq "12/01/1999".to_date }
			specify { expect(group.reload.finish_date).to eq "12/01/2000".to_date }
		end
	end

	describe 'new lecture' do

		before { visit new_group_lecture_path(group) }

		describe 'Show create class information' do
			it { should have_title("Nueva Clase") }
			it { should have_link("Regresar a Grupo") }
			it { should have_button("Guardar") }
		end

		describe "with invalid information" do
			it "should not create a lecture" do
				expect { click_button "Guardar" }.not_to change(Lecture, :count)
			end
			describe "error messages" do
				before { click_button "Guardar" }
				it { should have_content('error') }
			end
		end

		describe "with valid information" do
			before do
				fill_in 'lecture[observation]', :with => 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.'
				select '2014', from: 'lecture[date(1i)]'
				select 'January', from: 'lecture[date(2i)]'
				select '12', from: 'lecture[date(3i)]'
				select '09', from: 'lecture[date(4i)]'
				select '30', from: 'lecture[date(5i)]'
				
				expect { click_button "Guardar" }.to change(Lecture, :count).by(1)
			end
			it { should have_selector("div.alert.alert-success") }
			it { should have_content('Clase creada exitosamente') }
			it { should have_selector('td', text: "01/12/2014" ) }
			it { should have_selector('td', text: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam." ) }
		end
	end

	describe 'edit lecture' do
		
		before { visit edit_group_lecture_path(group, lecture) }

		it { should have_title('Editar Clase') }
		it { should have_button('Regresar a Grupo') }
		it { should have_button('Guardar') }
		it { should have_content('Fecha & hora') }

		describe 'with valid information' do
			before do
				fill_in 'lecture[observation]', :with => 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.'
				# puts find_field("lecture[date(1i)]").find('option[3]').value
				# find_field("lecture[date(1i)]").find('option')
				select '2016', from: 'lecture[date(1i)]'
				select 'February', from: 'lecture[date(2i)]'
				select '24', from: 'lecture[date(3i)]'
				select '12', from: 'lecture[date(4i)]'
				select '00', from: 'lecture[date(5i)]'

				click_button "Guardar"
			end

			it { should have_selector("div.alert.alert-success") }
			it { should have_content("Actualización Exitosa") }
		end

		describe 'Destroy lecture' do
			before { visit edit_group_lecture_path(group, lecture) }

			describe 'Show class information' do
		
				it { should have_title('Editar Clase') }
				it { should have_link("Regresar a Grupo") }
				it { should have_button("Borrar Clase") }

			end

			describe "Delete a class" do
		
				before do
					expect { click_link "Borrar Clase" }.to change(Lecture, :count).by(-1)
				end

				it { should have_selector("div.alert.alert-success") }
				it { should have_content('Clase borrada') }
				it { should have_title("Grupo #{group.name}") }
				it { should have_link("Nueva Clase") }

			end

		end

	end

	describe 'Should Spots in Group' do

		before { visit group_path(group) }

		describe 'Show group information' do
			it { should have_title("Grupo #{group.name}") }
			it { should have_link('Editar Grupo') }
			it { should have_content('Spots') }
		end

		describe 'Should render spots list on group' do

			it "should list each group" do
				group.spots.each do |child|
					expect(page).to have_selector('a', text: child.child.name)
				end
			end

		end

	end

end