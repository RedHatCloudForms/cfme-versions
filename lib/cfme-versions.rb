#!/usr/bin/env ruby --disable-gems
#
# When run as a program, prints a table of the current information.
#
# Otherwise, it can be required in a ruby script or rake task and manipulated as needed:
#
#     require 'cfme-versions'
#
#     CFME::Versions.first.cfme_release
#     #=> "5.1.z"
#     CFME::Versions.first.cloud_forms_release
#     #=> "2.0"
#     CFME::Versions.last.miq_release
#     #=> "Jansa"
#     CFME::Versions.last.ruby
#     #=> "2.5.z"
#     CFME::Versions.last
#     #=> #<struct CFME::Version miq_release="Jansa", cfme_release="5.12.z", cloud_forms_release="5.1", ruby="2.5.z", rails="5.2.z", postgresql="10.y">
#
module CFME
  Version = Struct.new(:miq_release, :miq_semver, :cfme_release, :cloud_forms_release, :ruby, :rails, :postgresql)

  class Versions
    extend Enumerable

    FIELDS   = [
         "ManageIQ",      "",       "CFME",  "CloudForms", "Ruby", "Rails", "PostgreSQL"
    ].freeze
    VERSIONS = [
      %w[ N/A             N/A        5.1.z    2.0           N/A     N/A      N/A        ],
      %w[ N/A             N/A        5.2.z    3.0           N/A     N/A      N/A        ],
      %w[ Anand           1.y.z      5.3.z    3.1           N/A     N/A      N/A        ],
      %w[ Botvinnik       2.y.z      5.4.z    3.2           N/A     N/A      N/A        ],
      %w[ Capablanca      3.y.z      5.5.z    4.0           2.2.z   4.2.z    9.4.z      ],
      %w[ Darga           4.y.z      5.6.z    4.1           2.2.z   5.0.z    9.4.z      ],
      %w[ Euwe            5.y.z      5.7.z    4.2           2.3.z   5.0.z    9.5.z      ],
      %w[ Fine            6.y.z      5.8.z    4.5           2.3.z   5.0.z    9.5.z      ],
      %w[ Gaprindashvili  7.y.z      5.9.z    4.6           2.3.z   5.0.z    9.5.z      ],
      %w[ Hammer          8.y.z      5.10.z   4.7           2.4.z   5.0.z    9.5.z      ],
      %w[ Ivanchuk        9.y.z      5.11.z   5.0           2.5.z   5.1.z    10.y       ],
    ].freeze

    class << self
      def run(argv = ARGV)
        until argv.empty?
          arg = argv.shift

          # The `return` statements are there for specs
          case arg
          when "--version"  then return print_version
          when "--help"     then return print_help
          end
        end

        CFME::Versions.print_table
      end

      def each
        versions.each { |version| yield version }
      end

      def last
        versions.last
      end

      def [](index)
        versions[index]
      end

      # Version of this gem/tool
      def version
        versions.last.miq_semver.split(".").first + ".0.0"
      end

      def versions
        @versions ||= raw_data.map { |data| Version.new(*data) }
      end

      def raw_data
        @raw_data ||= VERSIONS.dup
      end

      def print_help
        puts <<~HELP
          usage:  cfme-versions [OPTION]...

          Options:

              --version     Prints the version number and exits
              --help        This help

        HELP
        exit
      end

      def print_table
        # Print Header
        puts printable_row(FIELDS)
        puts printable_row(spacings.map { |size| "-" * size })

        # Print version data
        raw_data.each do |version|
          version_data = version.map { |column| column == "N/A" ? "" : column } # remove N/A values
          puts printable_row(version_data)
        end
      end

      def print_version
        puts CFME::Versions.version
        exit
      end

      private

      def printable_row(data)
        "| #{data.map.with_index { |header, index| header.ljust(spacings[index]) }.join(" | ")} |"
      end

      # Column width based on Miq::Versions.raw_data
      def spacings
        return @spacings if defined? @spacings

        @spacings = FIELDS.map(&:length)
        raw_data.each do |version|
          version.each.with_index do |col, index|
            @spacings[index] = [@spacings[index].to_i, col.length].max
          end
        end
        @spacings
      end
    end
  end
end

# Call run if this file is the file being executed
if $PROGRAM_NAME == __FILE__
  CFME::Versions.run
end
