require 'formula'

class Tomcat7 < Formula
  homepage "http://tomcat.apache.org/"
  url "http://www.apache.org/dyn/closer.cgi?path=tomcat/tomcat-7/v7.0.55/bin/apache-tomcat-7.0.55.tar.gz"
  sha1 "4e23f1e3d6d24e0affebe78f6f5c5d5a49eb4e37"

  option "with-fulldocs", "Install full documentation locally"

  resource "fulldocs" do
    url "http://www.apache.org/dyn/closer.cgi?path=/tomcat/tomcat-7/v7.0.55/bin/apache-tomcat-7.0.55-fulldocs.tar.gz"
    version "7.0.55"
    sha1 "2b2dc6835ebcaf12705cd3e60c40114e498651f0"
  end

  # Keep log folders
  skip_clean 'libexec'

  def install
    # Remove Windows scripts
    rm_rf Dir['bin/*.bat']

    # Install files
    prefix.install %w{ NOTICE LICENSE RELEASE-NOTES RUNNING.txt }
    libexec.install Dir['*']
    bin.install_symlink "#{libexec}/bin/catalina.sh" => "catalina"

    (share/'fulldocs').install resource('fulldocs') if build.with? 'fulldocs'
  end
end
