#!/usr/bin/env ruby
# encoding: utf-8

name "pycurl"
default_version "7.19.5.1"

dependency "python"
dependency "pip"

if ohai['platform'] != "windows"
  dependency "curl"
  dependency "gdbm" if (ohai['platform'] == "mac_os_x" or ohai['platform'] == "freebsd" or ohai['platform'] == "aix")
  dependency "libgcc" if (ohai['platform'] == "solaris2" and Omnibus.config.solaris_compiler == "gcc")

  build do
    ship_license "https://raw.githubusercontent.com/pycurl/pycurl/master/COPYING-MIT"
    build_env = {
      "PATH" => "/#{install_dir}/embedded/bin:#{ENV['PATH']}",
      # FIXME : eeeehm, shouldn't it rather be depending on the architecture of the build platform
      "ARCHFLAGS" => "-arch x86_64"
    }
    command "#{install_dir}/embedded/bin/pip install -I #{name}==#{version}", :env => build_env
  end
else
  version '7.43.0'
  wheel_name = "pycurl-7.43.0-cp27-none-win_amd64.whl"
  wheel_md5 = '66c232b0da1e8314cf3794c5644ff49f'

  source :url => "https://s3.amazonaws.com/dd-agent-omnibus/#{wheel_name}",
         :md5 => wheel_md5

  relative_path "pycurl-#{version}"

  build do
    pip "install #{wheel_name}"
  end
end
