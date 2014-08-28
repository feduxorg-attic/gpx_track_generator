#!/usr/bin/env rake

require 'filegen'
require 'fedux_org_stdlib/rake_tasks'
require 'active_support/all'
require 'open3'

def software
  gemspec.name
end

def module_name
  software.gsub(/-/, '/').camelcase
end

def require_name
  software
end

def gemspec
  # rubocop:disable Lint/Eval
  eval File.read(Dir.glob(File.join(File.expand_path('../', __FILE__), '*.gemspec')).first)
  # rubocop:enable Lint/Eval
end

def hardware_architecture
  `uname -m`.chomp
end

def archlinux_package_name
  File.join(archlinux_build_directory, "#{software}-#{version}-*-#{hardware_architecture}.pkg.tar.xz")
end

def version
  require "#{require_name}/version"
  "#{module_name}::VERSION".constantize
end

def root_directory
  ::File.expand_path('../', __FILE__)
end

def tar_file
  ::File.join(pkg_directory, "#{software}-#{version}.tar.gz")
end

def tmp_directory
  ::File.join(root_directory, 'tmp', "#{software}-#{version}")
end

def archlinux_build_directory
  ::File.join(root_directory, 'share', 'archlinux')
end

def gem_file
  ::File.join(root_directory, 'pkg', "#{software}-#{version}.gem")
end

def pkg_directory
  ::File.join(root_directory, 'pkg')
end

def gem_directory
  ::File.join(root_directory, 'vendor', 'cache')
end

task default: 'package:gem'

file tmp_directory do
  FileUtils.mkdir_p tmp_directory
end

file archlinux_build_directory do
  FileUtils.mkdir_p archlinux_build_directory
end

def extract_sha
  `makepkg -g 2>/dev/null`.split(/\n/).find { |l| l =~ /sha256/ }
end

namespace :package do

  desc 'build gem package'
  task :gem do
    sh 'RAILS_ENV=production bundle exec rake -f Rakefile.rails assets:clobber'
    sh 'RAILS_ENV=production bundle exec rake -f Rakefile.rails assets:precompile'

    base_path = File.expand_path('..', __FILE__)
    FileUtils.chmod_R 'a+r', Dir.glob(File.join(base_path, 'public', 'assets', '**', '*')).keep_if { |f| File.file? f }

    Rake::Task['gem:clean'].invoke
    Rake::Task['gem:build'].invoke
  end

  desc 'build arch linux package'
  task :archlinux do
    Rake::Task['archlinux:build'].invoke
  end
end

require 'coveralls/rake/task'
Coveralls::RakeTask.new

desc 'Run test suite'
task test: ['test:rspec', 'test:rubocop', 'test:cucumber']

namespace :test do
  desc 'Test with coveralls'
  task coveralls: ['test', 'coveralls:push']

  require 'rubocop/rake_task'
  RuboCop::RakeTask.new

  desc 'Run rspec'
  task :rspec do
    sh 'bundle exec rspec'
  end

  desc 'Run cucumber'
  task :cucumber do
    sh 'bundle exec cucumber -p all'
  end

  desc 'Run mutant'
  task :mutant do
    sh 'mutant --include lib --require middleman-presentation --use rspec "Middleman::Presentation*"'
  end
end

namespace :gem do
  desc 'Clean build packages'
  task :clean do
    FileUtils.rm Dir.glob(File.join(pkg_directory, '*.gem'))
  end
end

namespace :archlinux do
  desc 'Install arch linux package'
  task :install do
    sh "sudo pacman -U #{archlinux_package_name}"
  end

  desc 'Prepare package build'
  task prepare: ['package:gem', archlinux_build_directory] do
    generator = Filegen::Rubygen.new
    template = File.read(File.expand_path('../share/archlinux/PKGBUILD.sh.erb', __FILE__))
    build_file = File.expand_path('../share/archlinux/PKGBUILD', __FILE__)

    if ENV.key?('LOCAL_BUILD')
      package_file = ::File.join(pkg_directory, "#{software}-#{version}.gem")
      source       = ''
    else
      # package_file = '$pkgname-$pkgver.gem'
      package_file = '$pkgname'
      source       = 'http://gems.rubyforge.org/gems/$pkgname-$pkgver.gem'
    end

    data = {
      sha: nil,
      version: version,
      package: package_file,
      source: source
    }

    Dir.chdir(archlinux_build_directory) do
      File.open(build_file, 'w') do |f|
        f.write generator.run(template, data)
      end

      data = {
        sha: extract_sha,
        version: version,
        package: package_file,
        source: source
      }

      File.open(build_file, 'w') do |f|
        f.write generator.run(template, data)
      end
    end
  end

  desc 'Build package'
  task build: 'archlinux:prepare' do
    Dir.chdir(archlinux_build_directory) do
      sh 'makepkg -f'
    end
  end

  desc 'Build source package for aur'
  task build_source: 'archlinux:prepare' do
    Dir.chdir(archlinux_build_directory) do
      sh 'makepkg --source'
    end
  end
end

task 'gem:release' => :test
