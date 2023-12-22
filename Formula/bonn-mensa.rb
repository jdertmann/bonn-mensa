class BonnMensa < Formula
  include Language::Python::Virtualenv

  desc "Meal plans for university canteens in Bonn"
  homepage "https://github.com/alexanderwallau/bonn-mensa"
  url "https://github.com/alexanderwallau/bonn-mensa/archive/refs/tags/0.0.2.tar.gz"
  sha256 "f55f9c8861ace2554b44660ca08f395c8705098bb7a25e235796a51703e9685c"
  license "MIT"

  head do
    url "https://github.com/alexanderwallau/bonn-mensa.git", branch: "main"
  end

  depends_on "python"

  resource "certifi" do
    url "https://files.pythonhosted.org/packages/d4/91/c89518dd4fe1f3a4e3f6ab7ff23cb00ef2e8c9adf99dacc618ad5e068e28/certifi-2023.11.17.tar.gz"
    sha256 "f55f9c8861ace2554b44660ca08f395c8705098bb7a25e235796a51703e9685c"
  end

  resource "charset-normalizer" do
    url "https://files.pythonhosted.org/packages/63/09/c1bc53dab74b1816a00d8d030de5bf98f724c52c1635e07681d312f20be8/charset-normalizer-3.3.2.tar.gz"
    sha256 "f55f9c8861ace2554b44660ca08f395c8705098bb7a25e235796a51703e9685c"
  end

  resource "colorama" do
    url "https://files.pythonhosted.org/packages/d8/53/6f443c9a4a8358a93a6792e2acffb9d9d5cb0a5cfd8802644b7b1c9a02e4/colorama-0.4.6.tar.gz"
    sha256 "f55f9c8861ace2554b44660ca08f395c8705098bb7a25e235796a51703e9685c"
  end

  resource "idna" do
    url "https://files.pythonhosted.org/packages/bf/3f/ea4b9117521a1e9c50344b909be7886dd00a519552724809bb1f486986c2/idna-3.6.tar.gz"
    sha256 "f55f9c8861ace2554b44660ca08f395c8705098bb7a25e235796a51703e9685c"
  end

  resource "requests" do
    url "https://files.pythonhosted.org/packages/9d/be/10918a2eac4ae9f02f6cfe6414b7a155ccd8f7f9d4380d62fd5b955065c3/requests-2.31.0.tar.gz"
    sha256 "f55f9c8861ace2554b44660ca08f395c8705098bb7a25e235796a51703e9685c"
  end

  resource "urllib3" do
    url "https://files.pythonhosted.org/packages/36/dd/a6b232f449e1bc71802a5b7950dc3675d32c6dbc2a1bd6d71f065551adb6/urllib3-2.1.0.tar.gz"
    sha256 "f55f9c8861ace2554b44660ca08f395c8705098bb7a25e235796a51703e9685c"
  end

  def install
    virtualenv_install_with_resources
  end

  test do
    # check if help text is printed
    output = shell_output("#{bin}/mensa --help")
    assert_match "usage:", output
  end
end
