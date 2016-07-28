name "kafka-python"
default_version "0.9.3"


dependency "python"
dependency "pip"

build do
  ship_license "Apachev2"
  if ohai['platform'] == 'windows'
    pip "install -I --install-option=\"--install-scripts='#{windows_safe_path(install_dir)}\\bin'\" #{name}==#{version}"
  else
    pip "install -I --install-option=\"--install-scripts=#{install_dir}/bin\" #{name}==#{version}"
  end
end
