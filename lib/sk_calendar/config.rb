# frozen_string_literal: true

require 'i18n'

module SkCalendar
  ##
  # Configuration data for the SkCalendar module
  module Config
    ##
    #  @return [String] the path to the output file.
    def self.outfile
      project_root + '/html/planungGenerated.html'
    end

    ##
    # @return [String] the path to the main ics input file.
    def self.sk_calendar_file
      project_root + '/data/Singkreis-2018.ics'
    end
    ##
    # @return [String] the path to the school-holidays ics input file.
    def self.holidays_calendar_file
      project_root + '/data/Ferien_baden-wuerttemberg_2018.ics'
    end
    ##
    # @return [String] the path to the  ics input file.
    def self.month_file
      project_root + '/data/Lied_des_Monats.ics'
    end
    ##
    # @return [String] the path to the locale file.
    def self.locale
      project_root + '/config/locales/de.yml'
    end

    ##
    # Initializes the application.
    # 1. sets up the internationalisation i18n for german
    def self.setup
      return true if @is_setup
      I18n.load_path.append(locale)
      I18n.locale = :de
      @is_setup = true
    end

    ##
    # @return [String] the root path of this gem
    def self.project_root
      File.realpath('../..', __dir__)
    end
  end
end
