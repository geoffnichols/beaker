require 'beaker/hypervisor/vagrant'

class Beaker::VagrantLibvirt < Beaker::Vagrant
  @memory = nil
  @cpu    = nil

  class << self
    attr_reader :memory
  end

  def provision(provider = 'libvirt')
    super
  end

  def self.provider_vfile_section(host, options)
    "    v.vm.provider :libvirt do |node|\n" +
      "      node.cpus = #{cpus(host, options)}\n" +
      "      node.memory = #{memsize(host, options)}\n" +
      build_options_str(options) +
      "    end\n"
  end

  def self.build_options_str(options)
    other_options_str = ''
    if options['libvirt']
      other_options = []
      options['libvirt'].each do |k, v|
        other_options << "      node.#{k} = '#{v}'"
      end
      other_options_str = other_options.join("\n")
    end
    "#{other_options_str}\n"
  end
end
