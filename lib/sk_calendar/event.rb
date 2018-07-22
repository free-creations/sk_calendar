# frozen_string_literal: true

require 'icalendar/rrule/occurrence'
require 'sk_calendar/config'
require 'kramdown'
require 'i18n'

module SkCalendar
  ##
  # Reshape the Icalendar::Rrule::Occurrence class for our purpose.
  #
  # Provides formatting routines to generate HTML output.
  #
  # Format flags see: https://apidock.com/ruby/DateTime/strftime
  class Event
    ##
    # Creates a printable Event out of an occurrence.
    #
    # Sets up the locale for printing dates in german.
    # @param [Icalendar::Rrule::Occurrence] occurrence
    def initialize(occurrence)
      @occurrence = occurrence
      Config.setup
    end

    ##
    # @return [String] this event formatted as an HTML stream.
    def to_html
      if @occurrence.categories.include?('skHinweis')
        to_html_hint
      elsif @occurrence.categories.include?('skAuftritt')
        to_html_emphasis
      elsif @occurrence.categories.include?('skMonat')
        to_html_month
      else
        to_html_normal
      end
    end

    ##
    # @return [String] this event formatted as an HTML stream.
    def to_html_month
      <<~HTML
        <!--  ...................................... -->
        <hr />
        <h2>#{start_month} <small> - #{@occurrence.summary} #{formatted_location}</small></h2>
      HTML
    end

    ##
    # @return [String] this event formatted as an HTML stream.
    def to_html_hint
      <<~HTML
        <!--  ...................................... -->
        <div class="panel panel-default">
          <div class="panel-body">
            <h3 class="panel-title">#{start_end_time}
              <span class="sk-cal-summary">
                :: #{@occurrence.summary}
              </span>
               #{formatted_location}
            </h3>
               #{formatted_description}
          </div>
        </div>
      HTML
    end

    ##
    # @return [String] this event formatted as an HTML stream.
    def to_html_emphasis
      <<~HTML
        <!--  ...................................... -->
        <div class="panel panel-primary">
          <div class="panel-heading">
             <h3 class="panel-title" style="color:white;">#{start_end_time}
               <span class="sk-cal-summary">
               :: #{@occurrence.summary}
               </span>
               #{formatted_location}
             </h3>
          </div>
            #{formatted_description}
        </div>
      HTML
    end

    ##
    # @return [String] this event formatted as an HTML stream.
    def to_html_normal
      <<~HTML
        <!--  ...................................... -->
        <div class="panel panel-default">
          <div class="panel-heading">
             <h3 class="panel-title">#{start_end_time}<span class="sk-cal-summary"> :: #{@occurrence.summary}</span>
             #{formatted_location}</h3>
          </div>
            #{formatted_description}
        </div>
      HTML
    end

    ##
    # Nicely formats the start and end time of this event.
    #
    #
    # @return [String] the day and time of day when this event starts and ends
    def start_end_time
      if @occurrence.all_day?
        if @occurrence.multi_day?
          "#{start_day} - #{end_day}"
        else
          start_day.to_s
        end
      elsif @occurrence.multi_day?
        "#{start_day} #{start_time} - #{end_day} #{end_time} "
      else
        "#{start_day} #{start_time} - #{end_time} "
      end
    end

    ##
    # @return [String] the day when this event starts
    def start_day
      I18n.l @occurrence.start_time, format: '%a. %d. %-m.'
    end

    ##
    # @return [String] the day when this event ends
    def end_day
      if @occurrence.all_day?
        # all-day events end at 00:00 the day after the end-day
        I18n.l @occurrence.end_time.prev_day, format: '%a. %d. %-m.'
      else
        I18n.l @occurrence.end_time, format: '%a. %d. %-m.'
      end
    end

    ##
    # @return [String] the month when this event starts
    def start_month
      I18n.l @occurrence.start_time, format: '%B'
    end

    ##
    # @return [String] the hour and minute when this event starts
    def start_time
      I18n.l @occurrence.start_time, format: '%H:%M'
    end

    ##
    # @return [String] the hour and minute when this event ends
    def end_time
      I18n.l @occurrence.end_time, format: '%H:%M'
    end

    ##
    # @return [String] the occurrences description formatted as an HTML stream.
    def formatted_location
      return '' unless @occurrence.location
      "<span class='pull-right'>#{@occurrence.location}</span>"
    end

    ##
    # @return [String] the occurrences description formatted as an HTML stream.
    def formatted_description
      return '' unless @occurrence.description

      # we' ll interpret the description as a markdown text
      doc = Kramdown::Document.new(@occurrence.description)
      <<~HTML
        <div class="panel-body">
          #{doc.to_html}
        </div>
      HTML
    end
  end
end
