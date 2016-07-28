name "python-gearman"
default_version "2.0.2"

dependency "python"
dependency "pip"

build do
  ship_license "https://raw.githubusercontent.com/Yelp/python-gearman/master/LICENSE.txt"
  if ohai['platform'] == 'windows'
    pip "install -I --install-option=\"--install-scripts="\
             "'#{windows_safe_path(install_dir)}\\bin'\" gearman==#{version}"
  else
    pip "install -I --install-option=\"--install-scripts="\
             "#{install_dir}/bin\" gearman==#{version}"
  end
end
