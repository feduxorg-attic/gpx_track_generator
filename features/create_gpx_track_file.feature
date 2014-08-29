Feature: Create GPX Track File
  As a user
  I want to transform existing gpx routes or multiple gpx tracks to one gpx track
  In order to use them on my gps device

  Scenario: Create from gpx route files
    Given a gpx file named "route1.gpx"
    And a gpx file named "route2.gpx"
    When I successfully run `gpx_track g route1.gpx route2.gpx`
    Then a gpx file named "track.gpx" should exist with "4" track nodes

  Scenario: Create from gpx track files
    Given a gpx file named "track1.gpx"
    And a gpx file named "track2.gpx"
    When I successfully run `gpx_track g track1.gpx track2.gpx`
    Then a gpx file named "track.gpx" should exist with "4" track nodes

  Scenario: Change output file name
    Given a gpx file named "track1.gpx"
    And a gpx file named "track2.gpx"
    When I successfully run `gpx_track g --file track123.gpx track1.gpx track2.gpx`
    Then a gpx file named "track123.gpx" should exist

  Scenario: Define name
    Given a gpx file named "track1.gpx"
    And a gpx file named "track2.gpx"
    When I successfully run `gpx_track g --name "My Name" track1.gpx track2.gpx`
    Then the gpx file "track.gpx" should contain:
    """
    <name>My Name</name>
    """

  Scenario: Default name
    Given a gpx file named "track1.gpx"
    And a gpx file named "track2.gpx"
    When I successfully run `gpx_track g track1.gpx track2.gpx`
    Then the gpx file "track.gpx" should contain:
    """
    <name>Track #1</name>
    """

  Scenario: Normal order track
    Given a gpx file named "track1.gpx"
    And a gpx file named "track2.gpx"
    When I successfully run `gpx_track g track1.gpx track2.gpx`
    Then the gpx file "track.gpx" should contain:
    """
             <trkpt lat="56.688634024660372" lon="-6.5744374090151107">
                <name>WP 1</name>
                <ele>16.232316396783801</ele>
             </trkpt>
             <trkpt lat="57.688634024660372" lon="-6.5744374090151107">
                <name>WP 2</name>
                <ele>16.232316396783801</ele>
             </trkpt>
    """

  Scenario: Reverse track
    Given a gpx file named "track1.gpx"
    And a gpx file named "track2.gpx"
    When I successfully run `gpx_track g --reverse track1.gpx track2.gpx`
    Then the gpx file "track.gpx" should contain:
    """
             <trkpt lat="57.688634024660372" lon="-6.5744374090151107">
                <name>WP 2</name>
                <ele>16.232316396783801</ele>
             </trkpt>
             <trkpt lat="56.688634024660372" lon="-6.5744374090151107">
                <name>WP 1</name>
                <ele>16.232316396783801</ele>
             </trkpt>
    """
