require 'rails_helper'

feature "Customers", type: :feature do
  scenario 'Verificar o link de cadastro' do
    visit(root_path)
    expect(page).to have_link('Cadastro de brothers')
  end

  scenario 'Verificar caminho do link de cadastro' do
    visit(root_path)
    click_on('Cadastro de brothers')
    expect(page).to have_content('Listando brothers')
    expect(page).to have_link('Novo brother')
  end

  scenario 'Verificar novo brother' do
    visit(customers_path)
    click_on('Novo brother')
    expect(page).to have_content('Novo brother')
  end

  scenario 'Cadastra um brother válido' do
    visit(new_customer_path)
    customer_name = Faker::Name.name

    fill_in('Nome', with: customer_name)
    fill_in('Email', with: Faker::Internet.email)
    fill_in('Telefone', with: Faker::PhoneNumber.phone_number)
    attach_file('Foto do Perfil', "#{Rails.root}/spec/fixtures/zedeitado.jpeg")
    choose(option: ['S','N'].sample)
    click_on('Criar brother')
    expect(page).to have_content('Brother cadastrado com sucesso')
    expect(Customer.last.name).to eq(customer_name)
  end

  scenario 'Não cadastra um brother inválido' do
    visit(new_customer_path)
    click_on('Criar brother')
    expect(page).to have_content('não pode ficar em branco')
  end

  scenario 'Mostra um lixo' do
    customer = create(:customer)

    visit(customer_path(customer.id))
    expect(page).to have_content(customer.name)
    expect(page).to have_content(customer.email)
    expect(page).to have_content(customer.phone)
  end
 
  scenario 'Mostra lista com nomes' do
    customer1 = create(:customer)

    customer2 = create(:customer)

    visit(customers_path)
    expect(page).to have_content(customer1.name).and have_content(customer2.name)
  end

  scenario 'Mostra lista com nomes' do
    customer = create(:customer)

      new_name = Faker::Name.name
    visit(edit_customer_path(customer.id))
    fill_in('Nome', with: new_name)
    click_on('Atualizar brother')
    
    expect(page).to have_content('Brother atualizado com sucesso')
    expect(page).to have_content(new_name)
  end

  scenario 'Clica no link Mostrar da Index' do
    customer = create(:customer)

    visit(customers_path)
    find(:xpath, "/html/body/table/tbody/tr[1]/td[2]/a").click
    expect(page).to have_content("Mostrando brother")
  end

  scenario 'Clica no link Editar da Index' do
    customer = create(:customer)

    visit(customers_path)
    find(:xpath, "/html/body/table/tbody/tr[1]/td[3]/a").click
    expect(page).to have_content("Editando brother")
  end

  scenario 'Apaga um brother', js: true do
    customer = create(:customer)

    visit(customers_path)
    find(:xpath, "/html/body/table/tbody/tr[1]/td[4]/a").click
    1.second
    page.driver.browser.switch_to.alert.accept

    expect(page).to have_content('Brother excluído')
  end

end