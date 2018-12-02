describe SantaAssignService do
  before do
    create_list(:user, 9, :with_wish)
  end

  it 'Should assing santas' do
    described_class.call
    expect(User.without_santa).to be_empty
  end
end