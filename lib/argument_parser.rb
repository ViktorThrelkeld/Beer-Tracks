require 'optparse'

class ArgumentParser
  def self.parse
    options = { environment: "production" }
    OptionParser.new do |opts|
      opts.banner = "Usage: beertracks [command][option]"

      opts.on("--cost [COST]", "The cost") do |cost|
        options[:cost] = cost
      end

      opts.on("--id [ID]", "The id of the object we are editing") do |id|
        options[:id] = id
      end

      opts.on("--name [NAME]", "The name of the entry") do |name|
        options[:name] = name
      end

      opts.on("--ounces [OUNCES]", "The ounces") do |ounces|
        options[:ounces] = ounces
      end

      opts.on("--environment [ENV]", "The database environment") do |env|
       options[:environment] = env
      end
    end.parse!
    options[:name] ||= ARGV[1]
    options[:command] = ARGV[0]
    options
  end

  def self.validate options
    errors = []
    if options[:name].nil? or options[:name].empty?
      errors << "You must provide the name of the beer you drank."
    end

    missing_things = []
    missing_things << "cost" unless options[:cost]
    missing_things << "total ounces" unless options[:ounces]
    unless missing_things.empty?
      errors << "You must provide the #{missing_things.join(" and ")} of the beer you drank."
    end
    errors
  end
end