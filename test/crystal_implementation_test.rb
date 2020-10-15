require "test_helper"

class CrystalImplementation < Minitest::Test
  def cfme_versions_cr *args
    `crystal_build/cfme-versions #{args.join " "}`
  end

  def test_output_is_correct
    expected, _ = capture_io { CFME::Versions.print_help }
    assert_equal expected, cfme_versions_cr('--help')
  end

  def test_version_flag_is_correct
    expected, _ = capture_io { CFME::Versions.print_version }
    assert_equal expected, cfme_versions_cr('--version')
  end

  def test_help_text_is_correct
    expected, _ = capture_io { CFME::Versions.print_table }
    assert_equal expected, cfme_versions_cr
  end
end
