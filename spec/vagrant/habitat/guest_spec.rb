require "spec_helper"

RSpec.describe Vagrant::Habitat::Guest do
  it "has a version number" do
    expect(Vagrant::Habitat::Guest::VERSION).not_to be nil
  end

  it "does something useful" do
    expect(false).to eq(true)
  end
end
