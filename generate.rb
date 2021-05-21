# frozen_string_literal: true

require 'xcodeproj'
require 'optparse'
require 'fileutils'

# Generate
class Generate
  def run
    banner = "Usage: #{__FILE__} name [options]"
    options = {}
    optparse = OptionParser.new do |opt|
      opt.banner = banner
      opt.on('-d', '--dir PATH', 'Set the dir path') do |arg|
        options[:dir] = arg
      end
      opt.on('-t', '--type TYPE[objc|swift]', %i[swift objc], 'Set the project type, default is objc') do |arg|
        options[:type] = arg
      end
    end.parse!

    if optparse.empty?
      puts banner
      exit(-1)
    end

    name = optparse.first.to_s
    dir = options[:dir].to_s
    path = File.expand_path(name, (!dir.empty? ? dir : '.').to_s)
    type = options[:type].nil? ? 'objc' : options[:type].to_s

    if Dir.exist?(path)
      puts "#{path} already exist."
      # FileUtils.rm_r path
      exit(-1)
    end
    Dir.mkdir(path)

    base_project_name = case type
                        when 'objc'
                          'BaseProject_oc'
                        when 'swift'
                          'BaseProject_swift'
                        else
                          ''
                        end
    FileUtils.cp_r "#{File.dirname(__FILE__ )}/#{base_project_name}/.", path

    Dir["#{path}/**/*"].each do |fname|
      next unless File.file?(fname)

      data = File.read fname
      filtered_data = data.gsub(base_project_name, name)
      File.open(fname, 'w') do |f|
        f.write(filtered_data)
      end
    end

    Dir["#{path}/*"].each do |fname|
      new_name = fname.gsub(/#{base_project_name}/, name)
      File.rename(fname, new_name)
    end

    proj = Xcodeproj::Project.open("#{path}/#{name}.xcodeproj")
    proj.targets[0].build_configurations.each do |config|
      config.build_settings['PRODUCT_BUNDLE_IDENTIFIER'] = "com.doom.#{name}"
    end
    proj.save

    # cmd = 'pod install'
    # Dir.chdir path do
    #   `#{cmd}`
    # end
  end
end

Generate.new.run
