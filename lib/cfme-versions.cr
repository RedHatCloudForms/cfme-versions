module CFME
  class Versions
    FIELDS   = [
         "ManageIQ",      "",       "CFME",  "CloudForms", "CP4MCM", "Ruby", "Rails", "PostgreSQL"
    ]
    VERSIONS = [
      %w[ N/A             N/A        5.1.z    2.0           N/A       N/A     N/A      N/A        ],
      %w[ N/A             N/A        5.2.z    3.0           N/A       N/A     N/A      N/A        ],
      %w[ Anand           1.y.z      5.3.z    3.1           N/A       N/A     N/A      N/A        ],
      %w[ Botvinnik       2.y.z      5.4.z    3.2           N/A       N/A     N/A      N/A        ],
      %w[ Capablanca      3.y.z      5.5.z    4.0           N/A       2.2.z   4.2.z    9.4.z      ],
      %w[ Darga           4.y.z      5.6.z    4.1           N/A       2.2.z   5.0.z    9.4.z      ],
      %w[ Euwe            5.y.z      5.7.z    4.2           N/A       2.3.z   5.0.z    9.5.z      ],
      %w[ Fine            6.y.z      5.8.z    4.5           N/A       2.3.z   5.0.z    9.5.z      ],
      %w[ Gaprindashvili  7.y.z      5.9.z    4.6           N/A       2.3.z   5.0.z    9.5.z      ],
      %w[ Hammer          8.y.z      5.10.z   4.7           N/A       2.4.z   5.0.z    9.5.z      ],
      %w[ Ivanchuk        9.y.z      5.11.z   5.0           1.2,1.3   2.5.z   5.1.z    10.y       ],
      %w[ Jansa           10.y.z     N/A      N/A           2.0       2.5.z   5.2.z    10.y       ],
      %w[ Kasparov        11.y.z     N/A      N/A           N/A       2.6.z   5.2.z    10.y       ]
    ]

    def self.run(argv = ARGV)
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

    def self.version
      VERSIONS.last[1].split(".").first + ".0.0"
    end

    def self.print_help
      puts <<-HELP + "\n\n"
      usage:  cfme-versions [OPTION]...

      Options:

          --version     Prints the version number and exits
          --help        This help
      HELP
      exit
    end

    def self.print_table
      # Print Header
      puts printable_row(FIELDS)
      puts printable_row(spacings.map { |size| "-" * size })

      # Print version data
      VERSIONS.each do |version|
        version_data = version.map { |column| column == "N/A" ? "" : column } # remove N/A values
        puts printable_row(version_data)
      end
    end

    def self.print_version
      puts CFME::Versions.version
      exit
    end

    private def self.printable_row(data)
      "| #{data.map_with_index { |header, index| header.ljust(spacings[index]) }.join(" | ")} |"
    end

    @@spacings = [] of Int32

    # Column width based on Miq::Versions.raw_data
    private def self.spacings
      spacings = @@spacings
      return spacings unless spacings.empty?

      spacings = FIELDS.map(&.size)
      VERSIONS.each do |version|
        version.each.with_index do |col, index|
          spacings[index] = [spacings[index].to_i, col.size].max
        end
      end

      @@spacings = spacings
    end
  end
end

CFME::Versions.run
