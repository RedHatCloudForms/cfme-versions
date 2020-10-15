require "test_helper"

class CFME::Versions::Test < Minitest::Test
  DEFAULT_TABLE_DATA = <<~TABLE_DATA
| ManageIQ       |        | CFME   | CloudForms | CP4MCM  | Ruby  | Rails | PostgreSQL |
| -------------- | ------ | ------ | ---------- | ------- | ----- | ----- | ---------- |
|                |        | 5.1.z  | 2.0        |         |       |       |            |
|                |        | 5.2.z  | 3.0        |         |       |       |            |
| Anand          | 1.y.z  | 5.3.z  | 3.1        |         |       |       |            |
| Botvinnik      | 2.y.z  | 5.4.z  | 3.2        |         |       |       |            |
| Capablanca     | 3.y.z  | 5.5.z  | 4.0        |         | 2.2.z | 4.2.z | 9.4.z      |
| Darga          | 4.y.z  | 5.6.z  | 4.1        |         | 2.2.z | 5.0.z | 9.4.z      |
| Euwe           | 5.y.z  | 5.7.z  | 4.2        |         | 2.3.z | 5.0.z | 9.5.z      |
| Fine           | 6.y.z  | 5.8.z  | 4.5        |         | 2.3.z | 5.0.z | 9.5.z      |
| Gaprindashvili | 7.y.z  | 5.9.z  | 4.6        |         | 2.3.z | 5.0.z | 9.5.z      |
| Hammer         | 8.y.z  | 5.10.z | 4.7        |         | 2.4.z | 5.0.z | 9.5.z      |
| Ivanchuk       | 9.y.z  | 5.11.z | 5.0        | 1.2,1.3 | 2.5.z | 5.1.z | 10.y       |
| Jansa          | 10.y.z |        |            | 2.0,2.1 | 2.5.z | 5.2.z | 10.y       |
| Kasparov       | 11.y.z |        |            | 2.2     | 2.6.z | 5.2.z | 10.y       |
  TABLE_DATA

  def teardown
    # reset class variables
    CFME::Versions.teardown
  end

  def test_version
    assert_equal "11.0.0", CFME::Versions.version
  end

  def test_run
    actual = capture_io { CFME::Versions.run([]) }[0]
    assert_equal DEFAULT_TABLE_DATA, actual
  end

  def test_run_with_version_flag
    assert_equal "11.0.0", capture_io { CFME::Versions.run(["--version"]) }[0].chomp
  end

  def test_run_with_help_flag
    actual   = capture_io { CFME::Versions.run(["--help"]) }[0]
    expected = <<~HELP
      usage:  cfme-versions [OPTION]...

      Options:

          --version     Prints the version number and exits
          --help        This help

    HELP

    assert_equal expected, actual
  end

  def test_cfme_versions_first
    version = CFME::Versions.first

    assert_equal "N/A",   version.miq_release
    assert_equal "5.1.z", version.cfme_release
    assert_equal "2.0",   version.cloud_forms_release
    assert_equal "N/A",   version.cp4mcm_release
  end

  def test_cfme_versions_last
    version = CFME::Versions.last

    assert_equal "Kasparov", version.miq_release
    assert_equal "N/A",      version.cfme_release
    assert_equal "N/A",      version.cloud_forms_release
    assert_equal "2.2",      version.cp4mcm_release
  end

  def test_cfme_versions_specific_index
    version = CFME::Versions[10]

    assert_equal "Ivanchuk", version.miq_release
    assert_equal "5.11.z",   version.cfme_release
    assert_equal "5.0",      version.cloud_forms_release
    assert_equal "1.2,1.3",  version.cp4mcm_release
  end

  def test_enumerable
    actual   = CFME::Versions.reject { |version| version.miq_release == "N/A" }
                             .map(&:miq_release)
    expected = %w[
      Anand
      Botvinnik
      Capablanca
      Darga
      Euwe
      Fine
      Gaprindashvili
      Hammer
      Ivanchuk
      Jansa
      Kasparov
    ]

    assert_equal expected, actual
  end

  def test_readme_includes_proper_table
    readme_data = File.read(File.expand_path(File.join(*%w[.. .. README.md]), __FILE__))

    assert readme_data.include?(DEFAULT_TABLE_DATA),
           "README.md is not updated with new data!  Please update!"
  end
end
