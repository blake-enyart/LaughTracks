RSpec.describe "an unauthenticated user visits comedians page" do
  before(:each) do
    @c1 = Comedian.create(name: 'Mitch Hedberg', age: 50, city:"Los Angeles")
    @c2 = Comedian.create(name: 'Magic Mike', age: 50, city:"Los Angeles")
    @c3 = Comedian.create(name: 'Danger Dave', age: 48, city:"San Diego")
    @c4 = Comedian.create(name: 'Sunny Stella', age: 48, city:"Los Angeles")

    @s1 = @c1.specials.create(title: 'Mitch Hedberg: Funny Stuff', run_time: 10)
    @s2 = @c2.specials.create(title: 'Magic Mike: Funny Stuff', run_time: 2)
    @s3 = @c2.specials.create(title: 'Danger Dave: Funny Stuff', run_time: 3)
    @s4 = @c3.specials.create(title: 'Sunny Stella: Funny Stuff', run_time: 5)
  end

  context 'they see statistics for totals' do
    it 'and correct average run time displayed' do
      visit '/comedians'

      within ".statistics" do
        expect(page).to have_content("Average Runtime: 5")
      end
    end

    it 'and correct average age displayed' do
      visit '/comedians'

      within ".statistics" do
        expect(page).to have_content("Average Age: 49")
      end
    end

    it 'and correct unique cities displayed' do
      visit '/comedians'

      within ".statistics" do
        expect(page).to have_content("Unique Cities:\nLos Angeles\nSan Diego")
      end
    end
  end

  context 'see that each comedian has correct number of specials' do
    it 'views correct tv specials for each comedian' do
      visit '/comedians'

      within '.comedian-profile#magic-mike' do
        expect(page).to have_content('Number of Specials: 2')
      end

      within '.comedian-profile#mitch-hedberg' do
        expect(page).to have_content('Number of Specials: 1')
      end
    end
  end

  context 'they input info in the statistics inputs' do
    it 'input age and page displays correct number of comedians' do
      visit '/comedians'

      within '#age-input' do
        fill_in('age', with: 50)
        click_button('age-submit')
      end

      within '.main' do
        expect(page).to have_css('.comedian-profile', count: 2)
      end

      within '#age-input' do
        fill_in('age', with: 48)
        click_button('age-submit')
      end

      within '.main' do
        expect(page).to have_css('.comedian-profile', count: 2)
      end
    end
  end
end
