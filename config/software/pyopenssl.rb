name "pyopenssl"
# If you upgrade pyopenssl, you'll probably have to upgrade `cryptography` as well
default_version "0.14"

if ohai['platform'] == 'windows'
  dependency "openssl-windows"
  dependency "python"
  dependency "pip"
  dependency "cryptography"

  build do
    ship_license "https://raw.githubusercontent.com/pyca/pyopenssl/master/LICENSE"
    # No -I because we want to use the already installed version of `cryptography`
    pip "install pyopenssl==#{version}"
  end
else
  dependency "openssl"
  dependency "libffi"
  dependency "python"
  dependency "pip"

  build do
    ship_license "https://raw.githubusercontent.com/pyca/pyopenssl/master/LICENSE"
    build_env = {
      "PATH" => "/#{install_dir}/embedded/bin:#{ENV['PATH']}",
      "LDFLAGS" => "-L/#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
      "LD_RUN_PATH" => "#{install_dir}/embedded/lib",
      "CFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include/"
    }
    pip "install -I pyOpenSSL==#{version}", :env => build_env
  end
end
