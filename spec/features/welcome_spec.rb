require 'rails_helper'

RSpec.feature "Welcomes", type: :feature do
  scenario 'Mostra mensagem de eai' do
    visit (root_path)
    expect(page).to have_content('Eai')
  end

  scenario 'Verificar link de cadastro e lista' do
    visit (root_path)
    expect(page).to have_link('Cadastro de brothers')
    expect(page).to have_selector('ul li')
  end
# os dois scenarios testam a mesma coisa, mas de formas diferentes.
  scenario 'Verificar se o link de cadastro esta em uma lista' do
    visit (root_path)
    expect(find('ul li')).to have_link('Cadastro de brothers')
  end

end
