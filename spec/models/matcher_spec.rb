require 'rails_helper'

RSpec.describe Matcher do
  let(:unr) { create(:school, name: "UNR") }
  let(:unr2) { create(:school, name: "UNR") }
  let(:unr3) { create(:school, name: "UNR") }

  let!(:client) do
    create(
      :linkedin_profile,
      link: "client",
      client_type: "PotentialClient",
      schools: [unr]
    )
  end

  let!(:advisor) do
    create(
      :linkedin_profile,
      link: "advisor",
      client_type: "Advisor",
      schools: [unr2]
    )
  end

  describe '#create_matches' do
    it 'creates profile matches' do
      matcher = Matcher.new(client)
      expect {
        matcher.create_matches
        matcher.create_matches
      }.to change(ProfileMatch, :count).by(1)
    end
  end

  describe '#matches' do
    let(:unr) { create(:school, name: "UNR") }
    let(:unr2) { create(:school, name: "UNR") }
    let(:unr3) { create(:school, name: "UNR") }

    it 'returns a list of only other typed profiles' do
      create(:linkedin_profile, link: "client2", client_type: "PotentialClient")
      matcher = Matcher.new(client)
      expect(matcher.matches.count).to eq(1)
      expect(matcher.matches).to eq([advisor])
    end

    it 'returns a list that matches 2 or more fields' do
      advisor2 = create(:linkedin_profile, link: "advisor2", client_type: "Advisor", schools: [unr3])
      advisor3 = create(:linkedin_profile, link: "advisor3", client_type: "Advisor")
      matcher = Matcher.new(client)
      expect(matcher.matches).to eq([advisor, advisor2])
    end
  end
end
