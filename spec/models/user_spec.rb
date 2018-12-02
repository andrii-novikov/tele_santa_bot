describe User, type: :model do
  it { is_expected.to belong_to :santa }
  it { is_expected.to have_one :recipient }
  it { is_expected.to have_one :wish }

  it { is_expected.to validate_uniqueness_of :santa_id}
  it { is_expected.to validate_uniqueness_of :telegram_id}
  it { is_expected.to validate_presence_of :telegram_id}

  describe 'recipients' do
    let!(:user1) { create(:user, santa: santa) }
    let!(:santa) { create(:user) }

    it 'should have recipients' do
      expect(santa.recipient).to eq user1
    end
  end
end