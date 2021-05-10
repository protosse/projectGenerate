require 'xcodeproj'
require 'optparse'
require 'fileutils'

class Generate
  def run
    banner = "Usage: #{__FILE__} name [options]"
    options = {}
    optparse = OptionParser.new do |opt|
      opt.banner = banner
      opt.on('-d', '--dir PATH', 'Set the dir path') do |arg|
        options[:dir] = arg
      end
    end.parse!

    if optparse.empty?
      puts banner
      exit(-1)
    end

    name = optparse.first.to_s
    dir = options[:dir].to_s
    path = "#{dir.length > 0 ? dir : "."}/#{name}"

    if Dir.exist?(path)
      puts "#{path} already exist."
      # exit(-1)
      FileUtils.rm_r path
    end
    Dir.mkdir(path)

    project = Xcodeproj::Project.new("#{path}/#{name}.xcodeproj")
    group = project.main_group.new_group(name)
    %w[Controller Model View Util Vendor].each { |n|
      g = group.new_group(n)
      case n
      when "Controller"
        g.new_group("Base")
      end
    }

    project.save
  end
end

Generate.new.run