Feature: Create GPX Track File
  As a user
  I want to transform existing gpx routes or multiple gpx tracks to one gpx track
  In order to use them on my gps device

  Scenario: Create from gpx route files
    Given a gpx file named "route1.gpx"
    And a gpx file named "route2.gpx"
    And a converter script named "convert.rb" with
    """
    GpxTrackGenerator::Api.generate(
      input_files: %w(route1.gpx route2.gpx),
      output_file: 'track.gpx',
      track_name: 'My Name'
    )
    """
    When I successfully run `./convert.rb`
    Then a gpx file named "track.gpx" should exist with "4" track nodes

  Scenario: Create from gpx track files
    Given a gpx file named "track1.gpx"
    And a gpx file named "track2.gpx"
    And a converter script named "convert.rb" with
    """
    GpxTrackGenerator::Api.generate(
      input_files: %w(track1.gpx track2.gpx),
      output_file: 'track.gpx',
      track_name: 'My Name'
    )
    """
    When I successfully run `./convert.rb`
    Then a gpx file named "track.gpx" should exist with "4" track nodes

  Scenario: Define name
    Given a gpx file named "track1.gpx"
    And a gpx file named "track2.gpx"
    And a converter script named "convert.rb" with
    """
    GpxTrackGenerator::Api.generate(
      input_files: %w(track1.gpx track2.gpx),
      output_file: 'track.gpx',
      track_name: 'My Name'
    )
    """
    When I successfully run `./convert.rb`
    Then the gpx file "track.gpx" should contain:
    """
    <name>My Name</name>
    """

  Scenario: Normal order track
    Given a gpx file named "track1.gpx"
    And a gpx file named "track2.gpx"
    And a converter script named "convert.rb" with
    """
    GpxTrackGenerator::Api.generate(
      input_files: %w(track1.gpx track2.gpx),
      output_file: 'track.gpx',
      track_name: 'My Name'
    )
    """
    When I successfully run `./convert.rb`
    Then the gpx file "track.gpx" should contain:
    """
        <!-- track2.gpx -->
        <trkseg>
          <trkpt lat="56.688634024660372" lon="-6.5744374090151107">
            <name>WP 3</name>
            <ele>16.232316396783801</ele>
          </trkpt>
          <trkpt lat="57.688634024660372" lon="-6.5744374090151107">
            <name>WP 4</name>
            <ele>16.232316396783801</ele>
          </trkpt>
        </trkseg>
    """

  Scenario: Reverse track
    Given a gpx file named "track1.gpx"
    And a gpx file named "track2.gpx"
    And a converter script named "convert.rb" with
    """
    GpxTrackGenerator::Api.generate(
      input_files: %w(track1.gpx track2.gpx),
      output_file: 'track.gpx',
      track_name: 'My Name',
      reverse: true
    )
    """
    When I successfully run `./convert.rb`
    Then the gpx file "track.gpx" should contain:
    """
        <!-- track2.gpx -->
        <trkseg>
          <trkpt lat="57.688634024660372" lon="-6.5744374090151107">
            <name>WP 2</name>
            <ele>16.232316396783801</ele>
          </trkpt>
          <trkpt lat="56.688634024660372" lon="-6.5744374090151107">
            <name>WP 1</name>
            <ele>16.232316396783801</ele>
          </trkpt>
        </trkseg>
    """

  Scenario: Single segment
    Given a gpx file named "track1.gpx"
    And a gpx file named "track2.gpx"
    And a converter script named "convert.rb" with
    """
    GpxTrackGenerator::Api.generate(
      input_files: %w(track1.gpx track2.gpx),
      output_file: 'track.gpx',
      track_name: 'My Name',
      single_segment: true
    )
    """
    When I successfully run `./convert.rb`
    Then the gpx file "track.gpx" should contain:
    """
        <trkseg>
          <!-- track1.gpx -->
          <trkpt lat="55.688634024660372" lon="-5.5744374090151107">
            <name>WP 1</name>
            <ele>15.232316396783801</ele>
          </trkpt>
          <trkpt lat="57.688634024660372" lon="-5.5744374090151107">
            <name>WP 2</name>
            <ele>15.232316396783801</ele>
          </trkpt>
          <!-- track2.gpx -->
          <trkpt lat="56.688634024660372" lon="-6.5744374090151107">
            <name>WP 3</name>
            <ele>16.232316396783801</ele>
          </trkpt>
          <trkpt lat="57.688634024660372" lon="-6.5744374090151107">
            <name>WP 4</name>
            <ele>16.232316396783801</ele>
          </trkpt>
        </trkseg>
    """

  Scenario: One segment per track file
    Given a gpx file named "track1.gpx"
    And a gpx file named "track2.gpx"
    And a converter script named "convert.rb" with
    """
    GpxTrackGenerator::Api.generate(
      input_files: %w(track1.gpx track2.gpx),
      output_file: 'track.gpx',
      track_name: 'My Name',
      single_segment: false
    )
    """
    When I successfully run `./convert.rb`
    Then the gpx file "track.gpx" should contain:
    """
        <!-- track1.gpx -->
        <trkseg>
          <trkpt lat="55.688634024660372" lon="-5.5744374090151107">
            <name>WP 1</name>
            <ele>15.232316396783801</ele>
          </trkpt>
          <trkpt lat="57.688634024660372" lon="-5.5744374090151107">
            <name>WP 2</name>
            <ele>15.232316396783801</ele>
          </trkpt>
        </trkseg>
        <!-- track2.gpx -->
        <trkseg>
          <trkpt lat="56.688634024660372" lon="-6.5744374090151107">
            <name>WP 3</name>
            <ele>16.232316396783801</ele>
          </trkpt>
          <trkpt lat="57.688634024660372" lon="-6.5744374090151107">
            <name>WP 4</name>
            <ele>16.232316396783801</ele>
          </trkpt>
        </trkseg>
    """
