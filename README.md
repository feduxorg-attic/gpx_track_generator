# Gpx Track Generator

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

### Ruby

Create your track file from ruby code. This can be helpful in your `Rakefile`.

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

### CLI

*Create track file*

```
gpx_track *.gpx
```

*Define track name*

```
gpx_track --name "Track Name" *.gpx
```

TODO: Write usage instructions here

## Contributing

1. Fork it ( https://github.com/[my-github-username]/gpx_track_generator/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
