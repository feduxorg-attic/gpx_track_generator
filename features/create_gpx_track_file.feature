Feature: Create GPX Track File
  As a user
  I want to transform existing gpx routes or multiple gpx tracks to one gpx track
  In order to use them on my gps device

  Scenario: Create from gpx route files
    Given a gpx file named "route1.gpx"
    And a gpx file named "route2.gpx"
    When I successfully run `gpx_track g route1.gpx route2.gpx`
    Then a gpx file named "track.gpx" should exist
