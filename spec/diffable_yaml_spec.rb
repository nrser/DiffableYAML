require 'spec_helper'

describe DiffableYAML do
  it 'has a version number' do
    expect(DiffableYAML::VERSION).not_to be nil
  end

  describe ".dump" do
    data = {
      'c' => 3,
      'a' => 1,
      'b' => 2,
    }

    it "dumps keys in order" do
      yaml = NRSER.dedent <<-END
        ---
        a: 1
        b: 2
        c: 3
      END
      expect(DiffableYAML.dump(data)).to eq yaml
    end

    it "preorders keys" do
      yaml = NRSER.dedent <<-END
        ---
        c: 3
        b: 2
        a: 1
      END

      expect(DiffableYAML.dump(data, preorder: ['c', 'b'])).to eq yaml
    end
  end
end
