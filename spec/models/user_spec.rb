describe User, type: :model do
  it { is_expected.to belong_to :santa }
  it { is_expected.to have_many :recipients }
  it { is_expected.to have_many :wishes }

  describe 'recipients' do
    let(:user1) { create(:user, santa: santa) }
    let(:user2) { create(:user, santa: santa) }
    let(:santa) { create(:user) }

    it 'should have recipients' do
      expect(santa.recipients).to match_array([user1, user2])
    end
  end
end