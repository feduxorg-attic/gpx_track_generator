# Gpx Track Generator

[![Build Status](https://travis-ci.org/maxmeyer/gpx_track_generator.svg?branch=master)](https://travis-ci.org/maxmeyer/gpx_track_generator)
[![Gem Version](https://badge.fury.io/rb/gpx_track_generator.svg)](http://badge.fury.io/rb/gpx_track_generator)

This gem creates a single gpx track from all given gpx-files. Those files can
contain route- or track-points. This might be handy if you've got single
gpx-files for each part of a long distance walk, but don't want to litter your
gps-device.

## Installation

Add this line to your application's Gemfile:

    gem 'gpx_track_generator'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install gpx_track_generator

## Usage

### Introduction

The order of the gpx files which should be used by `gpx_track_generator` is
important. It iterates over all files an concatenate the found nodes one after
another. So make sure that all files are in the correct order.

#### Example:

```
file1.gpx => Part 1 of walk
file2.gpx => Part 2 of walk
file3.gpx => Part 3 of Walk
```

*CLI*

```bash
gpx_track file1.gpx file2.gpx file3.gpx
```


*Ruby*

```
input_files = %w(file1.gpx file2.gpx file3.gpx)
track_name  = 'Track ABC'
output_file = 'my_track.gpx'

GpxTrackGenerator::Api.generate(
  input_files: input_files,
  track_name: track_name,
  output_file: output_file
)
```

### Ruby

Create your track file from ruby code. This can be helpful in your `Rakefile`.

*Create track file*

```ruby
input_files = %w(track1.gpx route2.gpx)
track_name  = 'Track ABC'
output_file = 'my_track.gpx'

GpxTrackGenerator::Api.generate(
  input_files: input_files,
  track_name: track_name,
  output_file: output_file
)
```

*Reverse track*

```ruby
input_files = %w(track1.gpx route2.gpx)
track_name  = 'Track ABC'
output_file = 'my_track.gpx'

GpxTrackGenerator::Api.generate(
  input_files: input_files,
  track_name: track_name,
  output_file: output_file,
  reverse: true
)

*Single segment per Track*

```ruby
input_files = %w(track1.gpx route2.gpx)
track_name  = 'Track ABC'
output_file = 'my_track.gpx'

GpxTrackGenerator::Api.generate(
  input_files: input_files,
  track_name: track_name,
  output_file: output_file,
  single_segment: true
)
```

### CLI

*Create track file*

```
gpx_track *.gpx
```

*Define track name*

```
gpx_track --name "Track Name" *.gpx
```

*Reverse track*

```
gpx_track --reverse *.gpx
```

*Single Segment for the whole track*

```
gpx_track --single-segment *.gpx
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/gpx_track_generator/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
