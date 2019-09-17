require "test_helper"

class CFME::Versions::Test < Minitest::Test
  def teardown
    # reset class variables
    CFME::Versions.teardown
  end

  def test_version
    assert_equal "5.12", CFME::Versions.version
  end

  def test_run
    actual   = capture_io { CFME::Versions.run([]) }[0]
    expected = <<-OUTPUT.gsub(/^ {6}/, '')
      +----------------+------------------------------+------------+-------+-------+------------+
      | MANAGEIQ       | CLOUDFORMS MANAGEMENT ENGINE | CLOUDFORMS | RUBY  | RAILS | POSTGRESQL |
      +----------------+------------------------------+------------+-------+-------+------------+
      |                | 5.1.z                        | 2.0        |       |       |            |
      |                | 5.2.z                        | 3.0        |       |       |            |
      | Anand          | 5.3.z                        | 3.1        |       |       |            |
      | Botvinnik      | 5.4.z                        | 3.1        |       |       |            |
      | Capablanca     | 5.5.z                        | 4.0        | 2.2.z | 4.2.z | 9.4.z      |
      | Darga          | 5.6.z                        | 4.1        | 2.2.z | 5.0.z | 9.4.z      |
      | Euwe           | 5.7.z                        | 4.1        | 2.3.z | 5.0.z | 9.5.z      |
      | Fine           | 5.8.z                        | 4.5        | 2.3.z | 5.0.z | 9.5.z      |
      | Gaprindashvili | 5.9.z                        | 4.6        | 2.3.z | 5.0.z | 9.5.z      |
      | Hammer         | 5.10.z                       | 4.7        | 2.4.z | 5.0.z | 9.5.z      |
      | Ivanchuk       | 5.11.z                       | 5.0        | 2.5.z | 5.1.z | 10.y       |
      | Jansa          | 5.12.z                       | 5.1        | 2.5.z | 5.2.z | 10.y       |
      +----------------+------------------------------+------------+-------+-------+------------+
    OUTPUT
    assert_equal expected, actual
  end

  def test_run_with_markdown_flag
    actual   = capture_io { CFME::Versions.run(["--markdown"]) }[0]
    expected = <<-OUTPUT.gsub(/^ {6}/, '')
      | MANAGEIQ       | CLOUDFORMS MANAGEMENT ENGINE | CLOUDFORMS | RUBY  | RAILS | POSTGRESQL |
      |----------------|------------------------------|------------|-------|-------|------------|
      |                | 5.1.z                        | 2.0        |       |       |            |
      |                | 5.2.z                        | 3.0        |       |       |            |
      | Anand          | 5.3.z                        | 3.1        |       |       |            |
      | Botvinnik      | 5.4.z                        | 3.1        |       |       |            |
      | Capablanca     | 5.5.z                        | 4.0        | 2.2.z | 4.2.z | 9.4.z      |
      | Darga          | 5.6.z                        | 4.1        | 2.2.z | 5.0.z | 9.4.z      |
      | Euwe           | 5.7.z                        | 4.1        | 2.3.z | 5.0.z | 9.5.z      |
      | Fine           | 5.8.z                        | 4.5        | 2.3.z | 5.0.z | 9.5.z      |
      | Gaprindashvili | 5.9.z                        | 4.6        | 2.3.z | 5.0.z | 9.5.z      |
      | Hammer         | 5.10.z                       | 4.7        | 2.4.z | 5.0.z | 9.5.z      |
      | Ivanchuk       | 5.11.z                       | 5.0        | 2.5.z | 5.1.z | 10.y       |
      | Jansa          | 5.12.z                       | 5.1        | 2.5.z | 5.2.z | 10.y       |
    OUTPUT

    assert_equal expected, actual
  end

  def test_run_with_version_flag
    assert_equal "5.12", capture_io { CFME::Versions.run(["--version"]) }[0].chomp
  end

  def test_run_with_help_flag
    actual   = capture_io { CFME::Versions.run(["--help"]) }[0]
    expected = <<-HELP.gsub(/^ {6}/, '')
      usage:  cfme-versions [OPTION]...

      Options:

          --markdown    Print table in markdown format
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
  end

  def test_cfme_versions_last
    version = CFME::Versions.last

    assert_equal "Jansa",  version.miq_release
    assert_equal "5.12.z", version.cfme_release
    assert_equal "5.1",    version.cloud_forms_release
  end

  def test_cfme_versions_specific_index
    version = CFME::Versions[10]

    assert_equal "Ivanchuk", version.miq_release
    assert_equal "5.11.z",   version.cfme_release
    assert_equal "5.0",      version.cloud_forms_release
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
    ]

    assert_equal expected, actual
  end
end
