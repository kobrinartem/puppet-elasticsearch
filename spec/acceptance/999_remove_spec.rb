require 'spec_helper_acceptance'

  case fact('osfamily')
  when 'RedHat'
    package_name = 'elasticsearch'
    service_name = 'elasticsearch'
  when 'Debian'
    package_name = 'elasticsearch'
    service_name = 'elasticsearch'
  end

describe "module removal" do

  it 'should run successfully' do
    pp = "class { 'elasticsearch': ensure => 'absent' }"

    # Run it twice and test for idempotency
    apply_manifest(pp, :catch_failures => true)

  end

  describe file('/etc/elasticsearch') do
    it { should_not be_directory }
  end

  describe port(9200) do
    it {
      sleep 10
      should_not be_listening
    }
  end

  describe service(service_name) do
    it { should_not be_enabled }
    it { should_not be_running } 
  end

  describe package(package_name) do
    it { should_not be_installed }
  end

end