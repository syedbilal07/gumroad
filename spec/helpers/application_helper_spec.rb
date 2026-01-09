# frozen_string_literal: true

require "spec_helper"

describe ApplicationHelper do
  describe "#current_user_props" do
    let(:admin) { create(:admin_user, username: "gumroadian") }
    let(:seller) { create(:named_seller) }

    it "returns the current user props" do
      expect(current_user_props(admin, seller)).to eq(
                                                     {
                                                       name: "gumroadian",
                                                       avatar_url: admin.avatar_url,
                                                       impersonated_user: {
                                                         name: "Seller",
                                                         avatar_url: seller.avatar_url,
                                                       },
                                                     }
                                                   )
    end
  end

  describe "#number_to_si" do
    context "with numbers < 1000" do
      it "returns the number as a string" do
        expect(helper.number_to_si(0)).to eq "0"
        expect(helper.number_to_si(123)).to eq "123"
        expect(helper.number_to_si(999)).to eq "999"
      end
    end

    context "with numbers >= 1000 and < 1000000" do
      it "uses a 'K' suffix and displays one decimal point, if applicable" do
        expect(helper.number_to_si(1000)).to eq "1K"
        expect(helper.number_to_si(1100)).to eq "1.1K"
        expect(helper.number_to_si(10000)).to eq "10K"
        expect(helper.number_to_si(10100)).to eq "10.1K"
        expect(helper.number_to_si(10010)).to eq "10K"
      end
    end

    context "with numbers >= 1000000 and < 1000000000" do
      it "uses a 'M' suffix and displays one decimal point, if applicable" do
        expect(helper.number_to_si(1000000)).to eq "1M"
        expect(helper.number_to_si(1002000)).to eq "1M"
        expect(helper.number_to_si(1200000)).to eq "1.2M"
      end
    end

    it "does not round up" do
      expect(helper.number_to_si(99999)).to eq "99.9K"
      expect(helper.number_to_si(999999)).to eq "999.9K"
      expect(helper.number_to_si(9999999)).to eq "9.9M"
    end
  end

  describe "#icon_tag" do
    it "renders an icon with the correct mask style" do
      html = helper.icon_tag("solid-search")
      # Match the url dynamically, handling potential HTML escaping of single quotes
      expect(html).to match(/mask: url\((&#39;|').*\/icons\/solid-search-.*\.svg(&#39;|')\) center \/ 120% no-repeat/)
      expect(html).to include("inline-block bg-current shrink-0 align-middle w-[1em] min-h-[max(1lh,1em)]")
    end

    it "allows custom classes and options" do
      html = helper.icon_tag("solid-search", klass: "text-red-500", aria: { hidden: true })
      expect(html).to include("text-red-500")
      expect(html).to include('aria-hidden="true"')
    end
  end

  describe "#logo_tag" do
    context "with full variant (default)" do
      it "renders the full logo with correct mask style" do
        html = helper.logo_tag
        expect(html).to match(/mask: url\((&#39;|').*\/logo-.*\.svg(&#39;|')\) center \/ contain no-repeat/)
        expect(html).to include("width: 7.1428em")
      end

      it "allows custom classes" do
        html = helper.logo_tag(klass: "text-blue-500")
        expect(html).to include("text-blue-500")
      end
    end

    context "with 'g' variant" do
      it "renders the 'G' logo with background image" do
        html = helper.logo_tag(variant: "g")
        expect(html).to match(/background-image: url\((&#39;|').*\/logo-g-.*\.svg(&#39;|')\)/)
        expect(html).to include("block bg-contain bg-no-repeat w-[--big-icon-size] h-[--big-icon-size]")
      end
    end
  end
end
