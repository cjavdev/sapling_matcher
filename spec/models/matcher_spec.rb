require 'rails_helper'

RSpec.describe Matcher do
  describe '#match' do
    let(:client) do
      create(
        :linkedin_profile,
        link: "client",
        client_type: "PotentialClient"
      )
    end

    let(:advisor) do
      create(
        :linkedin_profile,
        link: "advisor",
        client_type: "Advisor"
      )
    end

    it 'returns a list of only other typed profiles' do
      create(:linkedin_profile, link: "client2", client_type: "PotentialClient")
      matcher = Matcher.new(client)
      expect(matcher.match).to eq([advisor])
    end

    it 'returns a list that matches 2 or more fields' do
      advisor2 = create(:linkedin_profile, link: "advisor2", client_type: "Advisor")
      advisor3 = create(:linkedin_profile, link: "advisor3", client_type: "Advisor")
      matcher = Matcher.new(client)
      expect(matcher.match).to eq([advisor, advisor2])
    end
  end
end
