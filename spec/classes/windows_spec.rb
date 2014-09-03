require 'spec_helper'

describe 'windows' do 
  context "on Windows" do
    let :facts do
      { :kernel => "windows" }
    end

    it { should compile }
  end

  context "on Linux" do
    let :facts do
      { :kernel => "Linux" }
    end

    it { should_not compile }
  end
end
